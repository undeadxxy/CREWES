function X=inverse_fgft(K)
% This function computes the inverse Generalized Fourier transform based on the
% paper by Robert Brown et al. (2010) 
% [IEEE TRANSACTIONS ON SIGNAL PROCESSING, VOL. 58, NO. 1, JANUARY 2010]
% The idea is to perform time-frequency analysis (Gabor, S-Transform,..)
% in a very efficient way and also saving fewer coefficients (namely the
% same size as the original data). 
%
%% Input
%   K: 1D general Fourier transform  
%
%% Output
%   X: 1D signal
%
% Author: Mostafa Naghizadeh; Copyright (C) 2010
%
% NOTE: This SOFTWARE may be used by any individual or corporation for any purpose
% with the exception of re-selling or re-distributing the SOFTWARE.
% By using this software, you are agreeing to the terms detailed in this software's
% Matlab source file.

% BEGIN TERMS OF USE LICENSE
%
% This SOFTWARE is maintained by the CREWES Project at the Department
% of Geology and Geophysics of the University of Calgary, Calgary,
% Alberta, Canada.  The copyright and ownership is jointly held by
% its 'AUTHOR' (identified above) and the CREWES Project.  The CREWES
% project may be contacted via email at:  crewesinfo@crewes.org
%
% The term 'SOFTWARE' refers to the Matlab source code, translations to
% any other computer language, or object code
%
% Terms of use of this SOFTWARE
%
% 1) This SOFTWARE may be used by any individual or corporation for any purpose
%    with the exception of re-selling or re-distributing the SOFTWARE.
%
% 2) The AUTHOR and CREWES must be acknowledged in any resulting publications or
%    presentations
%
% 3) This SOFTWARE is provided "as is" with no warranty of any kind
%    either expressed or implied. CREWES makes no warranties or representation
%    as to its accuracy, completeness, or fitness for any purpose. CREWES
%    is under no obligation to provide support of any kind for this SOFTWARE.
%
% 4) CREWES periodically adds, changes, improves or updates this SOFTWARE without
%    notice. New versions will be made available at www.crewes.org .
%
% 5) Use this SOFTWARE at your own risk.
%
% END TERMS OF USE LICENSE


% Determining the size of data
nk=length(K);

% Going to the next power of 2
n2=nextpow2(nk);

% % first and last 2 samples
% WW=zeros(1,nk);
% WW=W;
% FWW=fftshift(fft(WW));
% % Choosing only the middle part of the Fourier window
% WFWW=FWW(nk/2:nk/2+1);
% WFWW=WFWW/max(abs(WFWW));
% 
% % Positive frequencies
% K(nk-1:nk)=sqrt(2^(2-1))*ifft((K(nk-1:nk)./abs(WFWW)));
% K(1:2)=sqrt(2^(2-1))*ifft((K(1:2)./abs(WFWW)));

% Starting loop to pick parts of K and apply FFT in smaller sizes
for ia=2:n2-1
    % At each ia step we will take the fft of positive and
    % negative frequencies with variant window size.
    pfs=2^ia-2^(ia-1)+1;
    pfe=2^ia;
    nfs=(2^n2-(2^ia-2^(ia-1)+1)+1)-2^(ia-1)+1;
    nfe=2^n2-(2^ia-2^(ia-1)+1)+1;
    
    % % Making Gaussian window
    % W=gausswin(floor((2*nk)/((2^(ia-1)+1))),2.5);
    
    % % Hanning window
    % W = hamming(floor((2*nx)/((2^(ia-1)+1))));  % window
    % W(1) = W(1)/2;  % repair constant-overlap-add for R=(M-1)/2
    % W(floor((2*nx)/((2^(ia-1)+1)))) = W(floor((2*nx)/((2^(ia-1)+1))))/2;
    
    % % Making B-Spline window
    W=b_spline_window(floor((nk)/((2^(ia-1)))),2);
        
    % Padding zero for the rest of the window
    WW=zeros(1,nk);
    WW(1:floor((nk)/((2^(ia-1)))))=W;
    
    FWW=fftshift(fft(WW));
    % Choosing only the middle part of the Fourier window
    WFWW=FWW(nk/2-2^(ia-2)+1:nk/2+2^(ia-2));
    WFWW=WFWW/max(abs(WFWW));
    
    % Just using a box car as a frequency window
    %WFWW=ones(1,length(WFWW));
    
    % Positive frequencies
    K(pfs:pfe)=sqrt(2^(ia-1))*ifft((K(pfs:pfe)./abs(WFWW)));
   
    % Negative frequencies
    K(nfs:nfe)=sqrt(2^(ia-1))*ifft((K(nfs:nfe)./abs(WFWW)));
    
end

X=ifft(K);