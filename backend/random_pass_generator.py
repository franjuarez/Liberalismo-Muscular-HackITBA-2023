import random
import string

def generate_password(length=12):
    """Generate a random password with the given length."""
    # Define the characters that can be used in the password
    characters = string.ascii_letters + string.digits + string.punctuation

    password = ''.join(random.choice(characters) for i in range(length))
    return password