from config import *
from lint import lint
from data import get_data
from audio import *

if __name__ == "__main__":
    lint(JOHN)
    lint(NELL)
    get_data()
    get_audio(JOHN)
    get_audio(NELL)
    convert_to_mp3(JOHN)
    convert_to_mp3(NELL)
    upload_to_cos(JOHN)
    upload_to_cos(NELL)

