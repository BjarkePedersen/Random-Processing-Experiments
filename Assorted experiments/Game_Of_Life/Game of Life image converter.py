import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
import os

imgName = input("Enter name of file to convert: ")

img=mpimg.imread(imgName)	# Load Image from root path

# Find Resolution of image
shape = img.shape
print("Image resolution:",shape[0],"x",shape[1],"\n")

# Create empty numpy array from resolution
processedImg = np.zeros([shape[1],shape[0]])


# Apply image values to numpy array
for countx, i in enumerate(img):
	for county, f in enumerate(i):
			if f[0]<1:
				processedImg[county][countx] = 1

# Path to save image
path = os.getcwd()

# Open new .txt file in same path as .py file
f = open(path+"/"+imgName+".txt", "w")

# Write data to file
processedImg = processedImg.tolist()
for line in processedImg:
	f.write(str(line)+"\n")
f.close()

print("Created file: " + imgName + ".txt" + "\n" "at path: " + path + "\\")

# Show image
plt.figure(1)
plt.imshow(processedImg, cmap='Greys', interpolation='nearest')
plt.show()		# Show image


