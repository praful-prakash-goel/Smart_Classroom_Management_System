#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

struct ListNode* makeNode(int num)
{
    struct ListNode* newNode = (struct ListNode*) malloc(sizeof(struct ListNode));

    newNode->val = num;
    newNode->next = NULL;
    return newNode;
}

struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
    int sum;
    bool carry = false,dummy;
    struct ListNode* newList = NULL;
    struct ListNode* newNode = NULL;
    struct ListNode* prev = NULL;

    while(l1 != NULL || l2 != NULL )
    {
        if(l1 == NULL) sum = l2->val;
        else if(l2 == NULL) sum = l1->val;
        else sum = l1->val + l2->val;

        if(carry) 
        {
            sum++;
            carry = false;
        }
            
        if(sum >= 10)
        {
            int num = sum % 10;
            carry = true;
            newNode = makeNode(num);
        }
        if(!carry) newNode = makeNode(sum);
        if(newList == NULL) newList = newNode;
        else prev->next = newNode;
        prev = newNode;
        if(l1 != NULL) l1 = l1->next;
        if(l2 != NULL) l2 = l2->next;
    }
    if(carry)
    {
        newNode = makeNode(1);
        if(newList == NULL) newList = newNode;
        else prev->next = newNode;
        prev = newNode;
    }
    return newList;
}   