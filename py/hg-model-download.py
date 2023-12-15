import os
from transformers import AutoModelForCausalLM

model_name = "wizardlm/WizardCoder-Python-34B-V1.0"
save_path = "/vault/models/WizardCoder"

# Check if the save directory exists, create it if not
if not os.path.exists(save_path):
    os.makedirs(save_path)

try:
    model = AutoModelForCausalLM.from_pretrained(model_name, use_cache=False)
    model.save_pretrained(save_path)
    print(f"Model saved to {save_path}")
except Exception as e:
    print(f"An error occurred: {e}")
