% EEE391 Basics of Signals and Systems: Computer Assignment 2
% Author: Zeynep Cankara

%% 1) Implementing 1D M-point averaging filter

% chosen image: "houses.bmp"
A=imread("./images/houses.bmp");
J=mat2gray(A, [0 255]);
imageno = 1;

% Original image
figure;
imshow(J);
caption = sprintf('Original image: No filter applied');
title(caption, 'FontSize', 14);
pause(0.5);
    

for M = [11, 31, 61]
    % iterate over columns and perform average filtering
    Y = zeros(512,512);
    for col = 1:size(J,2)
        y = zeros(512,1);
        % find window range
        mid = (M-1)./2;
        lower = -1 * mid;
        upper = mid;
        % iterate over M window
        for i = lower:upper
            if (((i  + col) >= 1) && ((i + col) <= 512))
                y(:,1) = y(:,1)+ J(:,(i+col));
            else
            % pass 
            end
        end
        % assign the averaged column
        Y(:,col) = y./M;
    end
    % display the image
    figure(imageno);
    imshow(Y);
    m = M;
    caption = sprintf('One-dimensional M-point averaging filter applied (M: %d)', m);
    title(caption, 'FontSize', 14);
    imageno = imageno + 1;
end

%% 1) Introducing a random noise 

for c = [0.2, 1]
    noise = rand(512,512);
    noise = noise - (0.5 .* ones(512,512));
    noise = noise .* c;
    new_J = J + noise;
    for M = [11, 31, 61]
        % iterate over columns and perform average filtering
        Y = zeros(512,512);
        for col = 1:size(J,2)
            y = zeros(512,1);
            % find window range
            mid = (M-1)./2;
            lower = -1 * mid;
            upper = mid;
            % iterate over M window
            for i = lower:upper
                if (((i  + col) >= 1) && ((i + col) <= 512))
                    y(:,1) = y(:,1)+ new_J(:,(i+col));
                else
                % pass 
                end
            end
            % assign the averaged column
            Y(:,col) = y./M;
        end
        % display the image
        figure(imageno);
        imshow(Y);
        m = M;
        caption = sprintf('Random noise added to the image ( M: %d, c: %d )', m, c);
        title(caption, 'FontSize', 14);
        imageno = imageno + 1;
    end
end


%% 1.1) Frequency Response plot of Moving Average FIR filter in Q1

for M = [11, 31, 61]
    L = M;
    w = -pi:(pi/100):pi; %to plot frequency response
    H = [ones(1,L)]/L;
    H_old = H;
    [H,W] = freqz(H,1,w); 
    % add phase of (M-1)/2 to connect property of non-casual moving average
    H = H .* exp(((M-1)/2) .* 1j .* w);
    H_new = H;
    figure(imageno);
    plot(W,abs(H));
    caption = sprintf('Frequency Response plot, M: %d', M);
    title(caption, 'FontSize', 14);
    xlabel('Normalised Frequency (x pi rad/sample)');
    ylabel('Magnitude (dB)');
    imageno = imageno + 1;
end


%% 2) Implementing First Differencer Filter


% iterate over columns and perform average filtering
Y = zeros(512,512);
for col = 1:size(J,2)
    y = zeros(512,1);
    % find window range
    lower = -1;
    upper = 0;
    % iterate over M window
    for i = lower:upper
        if (((i  + col) >= 1) && ((i + col) <= 512))
            if (i == 0)
                y(:,1) = y(:,1)+ J(:,(i+col));
            else
                y(:,1) = y(:,1) - J(:,(i+col));
            end
        else
        % pass 
        end
    end
    % assign the averaged column
    Y(:,col) = y;
end

% display the image
figure(imageno);
imshow(Y);
caption = sprintf('First differencer applied image');
title(caption, 'FontSize', 14);
imageno = imageno + 1;

%% 2.2) Frequency response plot of first difference filter

w = -pi:(pi/10):pi; %sampled w values for frequency response plot
b = [1 -1];
a = [1];
figure(imageno);
[H,W] = freqz(b,a,w); %  magnitude response  graph
plot(W,abs(H));
xlabel('Normalised Frequency (x pi rad/sample)');
ylabel('Magnitude (dB)');
caption = sprintf('Frequency response plot of first differencer');
title(caption, 'FontSize', 14);
imageno = imageno + 1;

 


