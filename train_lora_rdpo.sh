lr=1e-6
beta=0.1

deepspeed --include=localhost:2,3 --master_port 60000 train_rdpo.py \
    --model_name_or_path liuhaotian/llava-v1.6-vicuna-7b \
    --data_path "./preference_data/pref_data.json" \
    --deepspeed "./deepspeed/zero2.json" \
    --per_device_train_batch_size 1 \
    --per_device_eval_batch_size 1 \
    --gradient_accumulation_steps 8 \
    --evaluation_strategy "no" \
    --save_strategy "epoch" \
    --save_total_limit 1 \
    --learning_rate $lr \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --bf16 True \
    --run_name "llava-vicuna-13b-rdpo-lora-$lr-beta-$beta-new-qkvo" \
    --lisa_enable False \
    --lora_enable True \
    --beta $beta \
    --output_dir "./output/llava-vicuna-13b-rdpo-lora-$lr-beta-$beta-new-qkvo" \
