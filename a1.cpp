#include <iostream>
#include <string>
#include <queue>

using namespace std;

typedef struct tokens
{
    string type = "";
    string content = "";
} token;

string Str;
queue<token> q_token;

//----------Custom----------//
void Clear(queue<token> &q);
string peek_type();
string peek_content();
bool get_STR(int pos, int *ptr);
bool get_ID(int pos, int *ptr);
//----------Custom----------//

//----------RDP----------//
void prog();
void stmts();
void stmt();
void primary();
void primary_tail();
//----------RDP----------//

int main()
{
    bool prog_or_not = true;
    int next = 0;
    while(cin >> Str)
    {
        next = 0;
        Clear(q_token);
        prog_or_not = true;
        //printf("STR size: %d\n", Str.size());
        for(int i = 0; i < Str.size(); ){

            if(Str[i] == '\"'){
                if(get_STR(i, &next)){
                    i = next;
                    i++;
                    continue;
                }
                else{
                    printf("invalid input\n");
                    prog_or_not = false;
                    break;
                }
            }else if( (Str[i]>='a'&& Str[i]<='z') || (Str[i]>='A'&& Str[i]<='Z') ||(Str[i] == '_') ){
                if(get_ID(i, &next)){
                    //printf("next is %d\n", next);
                    i = next;
                    continue;
                }
                else{
                    printf("invalid input\n");
                    prog_or_not = false;
                    break;
                }
            }else if(Str[i] == '('){
                token temp;
                temp.content = "LBR (";
                temp.type = "LBR";
                q_token.push(temp);
                i++;
            }else if(Str[i] == ')'){
                token temp;
                temp.content = "RBR )";
                temp.type = "RBR";
                q_token.push(temp);
                i++;
            }else if(Str[i] == '.'){
                token temp;
                temp.content = "DOT .";
                temp.type = "DOT";
                q_token.push(temp);
                i++;
            }

        }

        if(prog_or_not)
            prog();
        else
            continue;
    }
    return 0;
}
//----------Custom----------//
void Clear( queue<token> &q )
{
   while(!q.empty()){
        q.pop();
   }
}

string peek_type()
{
    return q_token.front().type;
}

string peek_content()
{
    return q_token.front().content;
}

bool get_STR(int pos, int *ptr)
{
    bool flag = false;
    int length = 0;
    token temp;
    for(int i = pos + 1; i < Str.size(); i++){
        if(Str[i] == '\"'){
            length = i - pos;
            *ptr = i;
            flag = true;
            break;
        }
    }
    temp.content = Str.substr(pos+1, length-1);
    temp.type = "STRLIT";
    q_token.push(temp);
    if(flag)
        return true;
    else
        return false;
}

bool get_ID(int pos, int *ptr)
{
    int length = 0;
    token temp;
    //printf("In get_ID, *ptr is %d\n", *ptr);
    for(int i = pos + 1; i < Str.size(); i++){
        if( (Str[i]>='a'&&Str[i]<='z') || (Str[i]>='A'&&Str[i]<='Z') || (Str[i]>='0'&&Str[i]<='9') || Str[i] == '_'){
            *ptr = i;
            if(i == Str.size() - 1){
                (*ptr)++;
                length = i - pos;
                temp.content = Str.substr(pos, length+1);
                temp.type = "ID";
                q_token.push(temp);
                return true;
            }
            continue;
        }else if(Str[i] == '(' || Str[i] == ')' || Str[i] == '.'){
            length = i - pos;
            *ptr = i;
            temp.content = Str.substr(pos, length);
            temp.type = "ID";
            q_token.push(temp);
            return true;
        }else{
            return false;
        }
    }
}
//----------Custom----------//

//----------RDP----------//
void stmt()
{
    //printf("in stmt()\n");
    if(peek_type() == "STRLIT"){
        cout << "STRLIT " << "\"" << peek_content() << "\"\n";
        q_token.pop();
    }else if(peek_type() == "ID" || peek_type() == "LBR" || peek_type() == "DOT"){
        primary();
    }else
        return;
}

void primary_tail()
{
    //printf("in primary_tail()\n");
    if(!q_token.empty()){
        if(peek_type() == "DOT"){
            cout << peek_content() << "\n";
        q_token.pop();
        cout << "ID " << peek_content() << "\n";
        q_token.pop();
        primary_tail();
        }else if(peek_type() == "LBR"){
            cout << peek_content() << "\n"; // left small bracket
            q_token.pop();
            stmt();
            cout << peek_content() << "\n"; // right small bracket
            q_token.pop();
            primary_tail();
        }
    }else{
        return;
    }

}

void primary()
{
    //printf("in primary()\n");
    cout << "ID " << peek_content() << "\n";
    q_token.pop();
    if(!q_token.empty()){
        primary_tail();
    }else{
        return;
    }
}

void stmts()
{
    //printf("in stmts()\n");
    stmt();
    if(!q_token.empty()){
        stmts();
    }else{
        return;
    }
}

void prog()
{
    //printf("in prog()\n");
    stmts();
}
//----------RDP----------//


/*
"test_string"
Test_ID
Str.length()
printf(¡§HelloWorld¡¨)
*/
