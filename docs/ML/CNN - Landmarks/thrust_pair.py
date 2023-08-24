"""CNN model with, three simple layers plus a pair of two paired. """


import torch
from torch import nn

class ThrustPair(nn.Module):
    """
    Three simple layers plus a pair of two paired.

    Tested against Landmarks from social media, 50 classes.
    Achieve a 50% accuracy, and when transferred learning got 70%

    Hipper parameters
    -----------------
        input_shape    = (3, 224, 224)
        valid_size     = 25e-2
        num_classes    = 50

        batch_size     = 32
        num_epochs     = 210

        dropout        = 40e-2
        learning_rate  = 45e-5
        momentum       = 85e-2

        opt            = 'sgd'
        weight_decay   = 45e-3
        thrust-pair
    """

    def __init__(
        self, input_shape = (3, 224, 224),
        num_classes: int = 1000, dropout: float = 0.40
    ):
        """
        Constructor

        Parameters
        ----------
            input_shape : tuple
                The size of the input image
            num_classes : int
                The number of classes to classify to
            dropout : float
                Amount of dropout for the Fully Connected layer
        """
        super().__init__()

        self.features = nn.Sequential(
            nn.Sequential(
                nn.Conv2d(input_shape[0], 64, 3, padding=1),
                nn.MaxPool2d(2, 2),
                nn.ReLU(inplace=True),
            ),
            nn.Sequential(
                nn.Conv2d(64, 128, 3, padding=1),
                nn.MaxPool2d(2, 2),
                nn.ReLU(inplace=True),
            ),
            nn.Sequential(
                nn.Conv2d(128, 256, 3, padding=1),
                nn.MaxPool2d(2, 2),
                nn.ReLU(inplace=True),
            ),
            nn.Sequential(
                nn.Conv2d(256, 512, 3, padding=1),
                nn.BatchNorm2d(512),
                nn.ReLU(inplace=True),

                nn.Conv2d(512, 512, 3, padding=1),
                nn.MaxPool2d(2, 2),
                nn.ReLU(inplace=True),
            ),
            nn.Sequential(
                nn.Conv2d(512, 1024, 3, padding=1),
                nn.BatchNorm2d(1024),
                nn.ReLU(inplace=True),

                nn.Conv2d(1024, 1024, 4, padding=1),
                nn.MaxPool2d(2, 2),
                nn.ReLU(inplace=True),
            ),
        )

        feature_output_size = self._get_flatten_size(input_shape)

        self.classifier = nn.Sequential(
            nn.Linear(feature_output_size, 5120),
            nn.ReLU(),

            nn.Linear(5120, 1024),
            nn.BatchNorm1d(1024),
            nn.ReLU(),
            nn.Dropout(p=dropout / 4),

            nn.Linear(1024, 512),
            nn.ReLU(),
            nn.Dropout(p=dropout),

            nn.Linear(512, num_classes),
            nn.LogSoftmax(dim=1)
        )


    def _get_flatten_size(self, input_shape):
        """
        Get the output size of the model to link the CNN to FC.

        Parameters
        ----------
            input_shape : tuple
                The size of the input image
        """
        x = torch.zeros((1, *input_shape))
        with torch.no_grad():
            output = self.features(x)
        batch_size, channels, height, width = output.size()
        return channels * height * width

    def forward(self, x):
        """
        Call the forward method to back propagate through the model.

        Parameters
        ----------
            x : tensor
                The input tensor.
        """
        x = self.features(x)
        x = x.view(x.size(0), -1) # Flatten
        x = self.classifier(x)
        return x
