#define N 4 
#include <stdbool.h> 
#include <stdio.h> 
/* r2ld is an array where its indices indicate row-col+N-1 
 (N-1) is for shifting the difference to store negative  
 indices */
int r2ld[16] = { 0 }; 
/* l2rd is an array where its indices indicate row+col 
   and used to check whether a queen can be placed on  
   right diagonal or not*/
int l2rd[16] = { 0 }; 
/*column array where its indices indicates column and  
  used to check whether a queen can be placed in that 
    row or not*/
int cl[8] = { 0 }; 

  
bool checkBoard(int board[N]) 
{
  int pos = 0;
  for (int i = 0; i < N; i++) { 
    pos = board[i];
    if ((r2ld[i - pos + N - 1] || 
         l2rd[i + pos] || cl[pos]))
      return false;
    /* Place this queen in board[i][col] */
    r2ld[i - pos + N - 1] =  1;
    l2rd[i + pos] = 1;
    cl[pos] = 1;
  }  
    /* If the queen cannot be placed in any row in 
        this colum col  then return false */
    return true; 
} 

void main()
{ int board[N] = {2, 3, 0, 1}; // the other good board: {1, 3, 0, 2}
  int x = checkBoard(board);
  printf("board is %s\n", x ? "good" : "bad");
}
