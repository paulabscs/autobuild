

class HelloWorld:
    def __init__(self, capitalization, punctuation):
        self.punctuation = punctuation
        self.message = self.get_hello(capitalization) 
        
    def get_hello(self, capitalization):
        edited_message = "Hello World" if capitalization else "hello world"
        return edited_message + self.punctuation


    def __str__(self):
        return self.message


