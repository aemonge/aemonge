import os
import torch

bin_files_path = "/vault/models/WizardCoder/"
output_path = "/vault/models/WizardCoder/WizardCoder-Python-34B-V1.0.bin"

# Create an empty state dictionary
state_dict = {}

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
device = "cpu"
if torch.cuda.is_available():
    print("CUDA-ing")
    torch.cuda.empty_cache()

# Load the weights from each bin file and merge them into the state dictionary
for bin_file in sorted(os.listdir(bin_files_path)):
    if bin_file.endswith(".bin"):
        model_state_dict = torch.load(
            os.path.join(bin_files_path, bin_file), map_location=device
        )
        state_dict |= model_state_dict

# Save the merged state dictionary as a single bin file
torch.save(state_dict, output_path)
