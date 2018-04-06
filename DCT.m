// Discrete cosine transform matrix
//dctmtx

A = im2double(imread('rice.png'));
imshow(A) // Read an image into the workspace and cast it to class double.
D = dctmtx(size(A,1)); //Calculate the discrete cosine transform matrix.
dct = D*A*D';
imshow(dct) //Multiply the input image A by D to get the DCT of the columns of A, and by D' to get the inverse DCT of the columns of A.
