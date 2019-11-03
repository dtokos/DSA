#ifndef rbt_hpp
#define rbt_hpp

// Source: https://stackoverflow.com/a/42803200

#include <stdio.h>
#include <stdlib.h>

#define RED   'R'
#define BLACK 'B'

typedef struct Node{
	int          key;
	char         color;
	struct Node *left;
	struct Node *right;
	struct Node *parent;
} Node;

// Based on CLRS algorithm, use T_Nil as a sentinel to simplify code
extern struct Node  T_Nil_Node;
extern Node* T_Nil;
extern Node* Root;

Node* newRBTNode(int key);
void rotateLeft( Node** T, Node* x);
void rotateRight(Node** T, Node* y);
void redBlackInsertFixup(Node** Root, Node* New);
void redBlackInsert(Node** T, int key);
int height(Node* Root);
int blackHeight(Node* Root);
void PrintHelper(Node* Root);
void redBlackTreePrint(Node* Root);
Node* redBlackSearch(Node* Root, int key);

#endif
