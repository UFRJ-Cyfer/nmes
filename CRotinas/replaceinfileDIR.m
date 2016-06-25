clc
pathname = uigetdir;
diretorio=dir(pathname);
pathname=[pathname '\'];

try
    m=2;
    while 1
        m=m+1;
        filename=diretorio(m).name;
        [s, msg] = replaceinfile(',','.',[pathname,filename], '-nobak');
    end
catch
    disp([num2str(m-2),' arquivos foram processados'])
end
