#!/usr/bin/env python3

"""Setup.py for project."""

from __future__ import absolute_import

from glob import glob
from os.path import basename, dirname, join, splitext

from setuptools import find_packages, setup


def read(name: str) -> list[str]:
    """Read a list of strings from file.

    Args:
        name (str): Name of file to read

    Returns:
        list[str]: File contents
    """
    with open(
        join(dirname(__file__), name),
    ) as fh:
        return [i.strip() for i in fh.readlines()]


setup(
    packages=find_packages("src"),
    package_dir={"": "src"},
    py_modules=[splitext(basename(path))[0] for path in glob("src/*.py")],
    install_requires=read("requirements.txt"),
    extras_require={"dev": read("requirements-dev.txt")},
)
