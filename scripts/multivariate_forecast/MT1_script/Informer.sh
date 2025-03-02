python3 ./scripts/run_benchmark.py --config-path "rolling_forecast_config.json" --data-name-list "MT1.csv" --strategy-args '{"horizon":288}' --model-name "time_series_library.Informer" --model-hyper-params '{"d_ff": 512, "d_model": 256, "horizon": 288, "seq_len": 1440, "batch_size": 32, "num_epochs": 20, "lr": 0.001}' --adapter transformer_adapter --gpus 0 --num-workers 1 --timeout 60000 --save-path "MT1/Informer" --formal-exp True --formal-exp True
