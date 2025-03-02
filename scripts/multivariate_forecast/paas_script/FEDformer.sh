python3 ./scripts/run_benchmark.py --config-path "rolling_forecast_config.json" --data-name-list "paas.csv" --strategy-args '{"horizon":144}' --model-name "time_series_library.FEDformer" --model-hyper-params '{"batch_size": 32, "d_ff": 256, "d_model": 128, "dropout": 0.05, "factor": 3, "moving_avg": 25, "horizon": 144, "seq_len": 720, "num_epochs": 20, "lr": 0.001}' --adapter transformer_adapter --gpus 0 --num-workers 1 --timeout 60000 --save-path "paas/FEDformer" --formal-exp True
