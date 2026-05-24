from PIL import Image
import os
import time
import multiprocessing as mp

def saveIn(name_img, img):
    full_path= os.path.join('processed', name_img)
    img.save(full_path)


image = 'котость.jpg'

def rotate(image):
    img = Image.open(image)
    rotated_image = img.rotate(90, expand=True)
    saveIn('out_rot_img.jpg', rotated_image)

def lan(image):  
    img = Image.open(image)
    img_lan = img.resize((800,600), Image.LANCZOS)
    saveIn('out_lam_img.jpg', img_lan)

def gray(image):
    img = Image.open(image)
    gray_img = img.convert('L')
    saveIn('out_gray_img.jpg', gray_img)

def sequential_processing(image):
    start_time = time.time()
    
    rotate(image)
    lan(image)
    gray(image)
    
    end_time = time.time()
    elapsed = end_time - start_time
    print(f"Время выполнения последовательно: {elapsed:.4f} секунд")
    return elapsed

def parallel_processing(image):
    start_time = time.time()
    
    with mp.Pool(processes=3) as pool:
        pool.apply_async(rotate, (image,))
        pool.apply_async(lan, (image,))
        pool.apply_async(gray, (image,))
        pool.close()
        pool.join()
    
    end_time = time.time()
    elapsed = end_time - start_time
    print(f"Время выполнения паралельно: {elapsed:.4f} секунд")
    return elapsed

time_seq = sequential_processing(image)

for file in os.listdir('processed'):
    os.remove(os.path.join('processed', file))

time_par = parallel_processing(image)

