python3 ./scripts/run_benchmark.py --config-path "rolling_forecast_config.json" --data-name-list "iaas.csv" --strategy-args '{"horizon":144}' --model-name "time_series_library.Informer" --model-hyper-params '{"d_ff": 256, "d_model": 128, "horizon": 144, "seq_len": 720, "batch_size": 32, "num_epochs": 20, "lr": 0.001}' --adapter transformer_adapter --gpus 0 --num-workers 1 --timeout 60000 --save-path "iaas/Informer" --formal-exp True
