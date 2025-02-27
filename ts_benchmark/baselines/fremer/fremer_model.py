import torch
import torch.nn as nn
from torch import Tensor
from ts_benchmark.baselines.fremer.FremerLayers import CompEncoderBlock


class T_Linear(nn.Module):
    def __init__(self, configs):
        super(T_Linear, self).__init__()
        self.seq_len = configs.seq_len
        self.pred_len = configs.pred_len
        self.linear = nn.Linear(self.seq_len, self.pred_len)
    
    def forward(self, x_enc):
        x_enc = x_enc.permute(0, 2, 1)
        pred = self.linear(x_enc).permute(0, 2, 1)
        return pred

class FremerModel(nn.Module):
    def __init__(self, configs):
        super(FremerModel, self).__init__()
        self.configs = configs
        self.seq_len = configs.seq_len
        self.pred_len = configs.pred_len
        self.low_cut = configs.low_cut
        
        self.t_pred = T_Linear(configs)
        self.model = CompEncoderBlock(configs)

    def forward(self, x_enc):
        t_means = torch.mean(x_enc, dim=1)
        x_enc = x_enc - t_means.unsqueeze(1).detach()
        
        init_pred = self.t_pred(x_enc)
        x_total = torch.cat([x_enc, init_pred], dim=1)
        
        freq = torch.fft.rfft(x_total, dim=1)  # [B, L, n_vars], dtype=torch.complex64
        freq = freq / x_total.shape[1]
        
        low_freq = freq[:, :self.low_cut, :]
        # high_freq = freq[:, self.low_cut:, :]

        # Frequency Normalization
        means = torch.mean(freq, dim=1)
        freq_abs = torch.abs(freq)
        stdev = torch.sqrt(torch.var(freq_abs, dim=1, keepdim=True))
        freq = (freq - means.unsqueeze(1).detach()) / stdev

        freq_pred = self.model(freq[:, self.low_cut:, :])

        # Frequency De-Normalization
        freq_pred = freq_pred * stdev
        freq_pred = freq_pred + means.unsqueeze(1).detach()

        # freq_pred[:, :self.low_cut, :] = low_freq
        freq_pred = torch.cat([low_freq, freq_pred], dim=1)
        freq_pred = freq_pred * freq_pred.shape[1]
        
        
        pred_seq = torch.fft.irfft(freq_pred, dim=1)[:, -self.configs.pred_len:]
        
        pred_seq = pred_seq + t_means.unsqueeze(1).detach() 
        
        return pred_seq
