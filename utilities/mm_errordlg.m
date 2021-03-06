function h=mm_errordlg(errorstring,dlgname,parent)
%function h=mm_errordlg(errorstring,dlgname,parent)
%
% See 'help errordlg' for usage
%
% Where:
%   parent     = handle to parent figure. Empty implies the parent is the
%                Matlab desktop
%
% This function uses mm_adjust to cause an errordialog to 
% display on the same monitor as the parent figure.
%
%  
%  Authors: Kevin Hall, 2017
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

narginchk(2,3)

if nargin<3
    parent = []; %Matlab desktop
end

if isempty(parent) || isa(parent,'handle')
    h = errordlg(errorstring,dlgname,'modal');
    mm_adjust(h,parent);
    uiwait(h);
else
    error(errorstring);
end

end %end function mm_errordlg