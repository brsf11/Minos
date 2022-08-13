#include<stdio.h>

void main()
{
    char equa[32],i,signum=0,sig,pointer;
    int a=0,b=0,res=0;
    while(1)
    {
        printf(">>>");
        gets(equa);
        i=0;
        signum=0;
        res=0;
        a=0;
        b=0;
        while(equa[i]!='\0')
        {
            switch(equa[i])
            {
                case '+':
                    signum++;
                    sig=0;
                    pointer=i;
                break;
                case '-':
                    signum++;
                    sig=1;
                    pointer=i;
                break;
                case '*':
                    signum++;
                    sig=2;
                    pointer=i;
                break;
                case '/':
                    signum++;
                    sig=3;
                    pointer=i;
                break;
                case '&':
                    signum++;
                    sig=4;
                    pointer=i;
                break;
                case '|':
                    signum++;
                    sig=5;
                    pointer=i;
                break;
                case '^':
                    signum++;
                    sig=6;
                    pointer=i;
                break;
                case '>':
                    signum++;
                    sig=7;
                    pointer=i;
                break;
                case '<':
                    signum++;
                    sig=8;
                    pointer=i;
                break;
                case '}':
                    signum++;
                    sig=9;
                    pointer=i;
                break;
                default:break;
            }
            i++;
        }
        if(signum!=1)
        {
            printf("too many or too few operators!\n");
            continue;
        }
        for(i=0;i<pointer;i++)
        {
            if((equa[i]<='9')&&(equa[i]>='0'))
            {
                a*=10;
                a+=equa[i]-'0';
            }
            else
            {
                printf("illegal oprand!\n");
                res=1;
            }
        }
        i++;
        while(equa[i]!='\0')
        {
            if((equa[i]<='9')&&(equa[i]>='0'))
            {
                b*=10;
                b+=equa[i]-'0';
            }
            else
            {
                printf("illegal oprand!\n");
                res=1;
            }
            i++;
        }
        if(res)
        {
            continue;
        }
        else
        {
            switch(sig)
            {
                case 0:
                    res=a+b;
                    printf("%d+%d=%d\n",a,b,res);
                break;
                case 1:
                    res=a-b;
                    printf("%d-%d=%d\n",a,b,res);
                break;
                case 2:
                    res=a*b;
                    printf("%d*%d=%d\n",a,b,res);
                break;
                case 3:
                    res=a/b;
                    printf("%d/%d=%d\n",a,b,res);
                break;
                case 4:
                    res=a&b;
                    printf("%d&%d=%d\n",a,b,res);
                break;
                case 5:
                    res=a|b;
                    printf("%d|%d=%d\n",a,b,res);
                break;
                case 6:
                    res=a^b;
                    printf("%d^%d=%d\n",a,b,res);
                break;
                case 7:
                    res=(unsigned)a>>b;
                    printf("%d>>%d=%d\n",a,b,res);
                break;
                case 8:
                    res=a<<b;
                    printf("%d<<%d=%d\n",a,b,res);
                break;
                case 9:
                    res=a>>b;
                    printf("%d>>>%d=%d\n",a,b,res);
                break;
                default:break;
            }
        }
    }
}