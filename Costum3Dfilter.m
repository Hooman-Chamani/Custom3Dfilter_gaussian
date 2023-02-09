A = rand([300 300 300]); % 3-D image
sigma_x = 1;
sigma_y = 2;
sigma_z_eqn = '2.*z'; % string representing equation for sigma_z
z = (1:300)';
filtered_A = custom3Dfilter(A, sigma_x, sigma_y, sigma_z_eqn, z);

function filtered_A = custom3Dfilter(A, sigma_x, sigma_y, sigma_z_eqn, z)

% Evaluate sigma_z at each z coordinate
sigma_z = eval(sigma_z_eqn);

% Pre-allocate space for the filtered image
filtered_A = zeros(size(A));

% Filter the image with a 3-D Gaussian filter
for i = 1:length(sigma_z)
    g = fspecial3('gaussian', [round(6*sigma_x), round(6*sigma_y), round(6*sigma_z(i))], [sigma_x, sigma_y, sigma_z(i)]);
    filtered_A(:,:,i) = imfilter(A(:,:,i), g, 'replicate');
end

end

%%%The argument [round(6*sigma_x), round(6*sigma_y), round(6*sigma_z(i))] in the fspecial3 function specifies the size of the 3-D Gaussian filter in each direction (x, y, and z). The round function is used to round the size to the nearest integer value, as fspecial3 requires integer values for the filter size. The factor of 6 is used to determine the size of the filter. The value 6*sigma is a commonly used rule-of-thumb to determine a reasonable filter size that includes most of the energy of a Gaussian function with standard deviation sigma. By rounding the result to the nearest integer, we ensure that the filter size is an integer value that can be used as an input to fspecial3. So, the argument [round(6*sigma_x), round(6*sigma_y), round(6*sigma_z(i))] specifies that the size of the filter in the x direction is round(6*sigma_x), the size of the filter in the y direction is round(6*sigma_y), and the size of the filter in the z direction is round(6*sigma_z(i)), where i is the current index into the sigma_z array.