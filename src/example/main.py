#!/usr/bin/env python3


def greet(name: str) -> str:
    """Greet a person.

    Args:
        name (str): Name of person to greet.

    Returns:
        str: greeting.
    """
    return f"Hello, {name}"


if __name__ == "__main__":
    print(greet("Tory"))
