#!/bin/bash

# pip install poetry neovim-remote

poetry add -G lint autoflake bandit black darglint docformatter flake8 flake8-annotations flake8-bandit
poetry add -G lint flake8-black flake8-blind-except flake8-bugbear flake8-builtins flake8-comprehensions
poetry add -G lint flake8-docstring-checker flake8-docstrings flake8-eradicate flake8-isort
poetry add -G lint flake8-picky-parentheses flake8-print flake8-quotes flake8-string-format flake8-todo
poetry add -G lint flake8-unused-arguments isort pep8-naming pylsp-rope pyright sourcery-cli
poetry add -G lint toml types-toml

poetry add -G debug debugpy ipdb
# poetry add -G test faker
#
poetry add fastapi # beanie
#
# poetry add aiofiles click watchdog beautifulsoup4
