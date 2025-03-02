python3 ./scripts/run_benchmark.py --config-path "rolling_forecast_config.json" --data-name-list "iaas.csv" --strategy-args '{"horizon":144}' --model-name "time_series_library.DLinear" --model-hyper-params '{"d_ff": 64, "d_model": 32, "lr": 0.001, "horizon": 144, "seq_len": 720, "batch_size": 32, "num_epochs": 20}' --adapter transformer_adapter --gpus 0 --num-workers 1 --timeout 60000 --save-path "iaas/DLinear" --formal-exp True
