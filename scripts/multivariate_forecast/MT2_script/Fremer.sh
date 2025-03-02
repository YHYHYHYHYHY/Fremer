python3 ./scripts/run_benchmark.py --config-path "rolling_forecast_config.json" --data-name-list "MT2.csv" --strategy-args '{"horizon":288}' --model-name "fremer.Fremer" --model-hyper-params '{"low_cut": 40, "d_model": 128, "d_ff": 256, "loss": "MSE", "batch_size": 32,  "horizon":288, "seq_len": 1440, "patience": 10, "lr": 0.001}'  --gpus 0  --num-workers 1  --timeout 60000  --save-path "MT2/Fremer"