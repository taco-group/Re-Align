<p align="center" width="60%">
<img src="asset/pics/logo-realign.png" alt="Re-Align" style="width: 35%; min-width: 200px; display: block; margin: auto; background-color: transparent;">
</p>

<div id="top" align="center">

[![](https://img.shields.io/badge/Project%20Page-8A2BE2)](https://taco-group.github.io/Re-Align/)
![Code License](https://img.shields.io/badge/Code%20License-Apache%202.0-brightgreen)
[![arXiv](https://img.shields.io/badge/arXiv-2502.13146-b31b1b.svg)](https://arxiv.org/abs/2502.13146)

</div>

# Re-Align: Aligning Vision Language Models via Retrieval-Augmented Direct Preference Optimization

**Re-Align** is a novel alignment framework that leverages image retrieval, which not only mitigates hallucinations more effectively than previous methods but also yields significant performance gains in general visual question-answering (VQA) tasks. Moreover, Re-Align maintains robustness and scalability across a wide range of VLM sizes and architectures. 

<div align="center">
  <img src="asset/pics/radar-teaser.png" alt="EMMA diagram" width="800"/>
  <p><em>Figure 1. Benchmark performance comparison (min-max normalized).</em></p>
</div>

### Key Highlights

- **Controlled Hallucination Injection:** Re-Align deliberately injects controlled hallucinations into chosen responses using image retrieval, generating rejected responses that offer more plausible and natural preference signals regarding hallucinations.

- **Dual Preference Dataset:**  By incorporating both the retrieved image and the original input image, Re-Align constructs a dual-preference dataset. 

- **Alignment via rDPO:** Our proposed rDPO objective—an extension of DPO that includes an additional visual preference optimization objective, further enhancing the alignment process with valuable visual preference signals.

### News
- **[2025/2/18]** 🔥We released **Re-Align**, a novel alignment framework that leverages image retrieval to mitigate hallucinations in Vision Language Models. Explore our [paper](https://arxiv.org/abs/2502.13146) and [website](https://taco-group.github.io/Re-Align/) for more details.

## Installation

1. Create a virtual environment with Conda and activate.
```Shell
conda create -n re-align python=3.10 -y
conda activate re-align
```

2. Install packages
```Shell
pip install --upgrade pip  
pip install -e .
pip install -e ".[train]"
pip install flash-attn --no-build-isolation
pip install trl
```

3. Replace `dpo_trainer.py` with `Re-Align/dpo_trainer. py`. 
```Shell
rm /home/username/anaconda3/envs/re-align/lib/python3.10/site-packages/trl/trainer/dpo_trainer.py 
cp ./Re-Align/dpo_trainer.py /home/username/anaconda3/envs/re-align/lib/python3.10/site-packages/trl/trainer/
```

# Usage
After setting up the environment, you can start using Re-Align with the following instructions:

1. Download the entire train2014 split from MSCOCO.  
```Shell
cd dataset
wget http://images.cocodataset.org/zips/train2014.zip 
unzip train2014.zip
```

2. **Run Re-Align**  
    Use the following command to train `llava-v1.6-vicuna-7b` with Re-Align:
    - Quick Start:
    ```bash
    bash trian_lora_rdpo.sh
    ```
    - Command:
    ```bash
    deepspeed --include=localhost:0,1,2,3 --master_port 60000 train_rdpo.py \
      --model_name_or_path liuhaotian/llava-v1.6-vicuna-7b \
      --data_path "./preference_data/pref_data.json" \
      --deepspeed "./deepspeed/zero2.json" \
      --per_device_train_batch_size 1 \
      --per_device_eval_batch_size 1 \
      --gradient_accumulation_steps 8 \
      --evaluation_strategy "no" \
      --save_strategy "epoch" \
      --save_total_limit 1 \
      --learning_rate 1e-6 \
      --weight_decay 0. \
      --warmup_ratio 0.03 \
      --lr_scheduler_type "cosine" \
      --bf16 True \
      --lisa_enable False \
      --lora_enable True \
      --beta 0.1 \
      --output_dir "./output/llava-vicuna-7b-rdpo-lora-1e-6-beta-0.1" \

    ```

## Citation
We are more than happy if this code is helpful to your work. 
If you use our code or extend our work, please consider citing our paper:

```bibtex

@article{Xing2025Feb,
	author = {Xing, Shuo and Wang, Yuping and Li, Peiran and Bai, Ruizheng and Wang, Yueqi and Qian, Chengxuan and Yao, Huaxiu and Tu, Zhengzhong},
	title = {{Re-Align: Aligning Vision Language Models via Retrieval-Augmented Direct Preference Optimization}},
	journal = {arXiv},
	year = {2025},
	month = feb,
	eprint = {2502.13146},
	doi = {10.48550/arXiv.2502.13146}
}