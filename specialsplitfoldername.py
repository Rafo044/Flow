
import os

def remove_trailing_whitespace(directory):
    for root, directories, files in os.walk(directory, topdown=False):
        # Change folder name
        for folder in directories:
            folder_path = os.path.join(root, folder)
            new_name = folder.rsplit(' ', 1)[0]  # Special split
            new_folder_path = os.path.join(root, new_name)
            os.rename(folder_path, new_folder_path)
        
        # Change file name
        for file in files:
            file_path = os.path.join(root, file)
            name, extension = os.path.splitext(file)
            new_name = name.rsplit(' ', 1)[0]  # Special split
            new_file_path = os.path.join(root, new_name + extension)
            os.rename(file_path, new_file_path)

if __name__ == "__main__":
    folder_path = "/var/home/rafo/Belgeler/Export-13aa028a-40ed-4a4b-8d57-dcf28da227d1"  #Folder path
    remove_trailing_whitespace(folder_path)
