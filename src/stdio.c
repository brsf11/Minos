#define ADDR_REMPTY 16384
#define ADDR_RDATA 16385
#define ADDR_WFULL 16386
#define ADDR_WDATA 16387

char getc();
void gets(char* a);
void putc(char a);
void printf(char* a);
void print(int a);

char getc()
{
    char* rempty;
    char* rdata;
    rempty=(char*)ADDR_REMPTY;
    while(*rempty);
    rdata=(char*)ADDR_RDATA;
    return *rdata;
}

void gets(char* a)
{
    int i=0;
    while((*(a+i)=getc())!='\n')
    {
        i++;
    }
    *(a+i)='\0';
}

void putc(char a)
{
    char* wfull;
    char* wdata;
    wfull=(char*)ADDR_WFULL;
    while(*wfull);
    wdata=(char*)ADDR_WFULL;
    *wdata=a;
}

void printf(char* a)
{
    int i=0;
    while(*(a+i)!='\0')
    {
        putc(*(a+i));
    }
}

void print(int a)
{
    char str1[11],str2[11];
    int i=0,j;
    while(a>=10)
    {
        str1[i]='0'+a%10;
        a/=10;
        i++;
    }
    str1[i]='0'+a;
    for(j=i;j>=0;j--)
    {
        str2[i-j]=str1[j];
    }
    str2[i+1]='\0';
    printf(str2);
}