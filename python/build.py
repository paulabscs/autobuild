import os, sys
import random

# Ensure your Python path includes the parent directory for imports
sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))

from python.classes.test_class import HelloWorld
from python.utils.hello_world import say_hi

# Produce a HelloWorld object
first_hello = HelloWorld(False,'.')

# Produce another HelloWorld object
second_hello = HelloWorld(True,'!')

greeting_array = [first_hello, second_hello]

random_index = random.randint(0, len(greeting_array) - 1)

say_hi(greeting_array[random_index])