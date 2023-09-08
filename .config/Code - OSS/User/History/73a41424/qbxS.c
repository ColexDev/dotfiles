#include <stdlib.h>
#include <stdio.h>

#include "answer05.h"

// FIX: Have this return the tree, this is needed for building the big huffman tree
btree*
dequeue(pqnode** head)
{
    pqnode* temp = *head;
    btree* ret = NULL;

    if (*head == NULL) {
        return NULL;
    }

    *head = (*head)->next;

    // ret = &(temp->data);
    ret = temp->data;

    free(temp);
    return ret;
}

int
enqueue(pqnode** head, btree* data, unsigned long priority)
{
    pqnode* curr = *head;
    pqnode* temp = calloc(1, sizeof(pqnode));
    if (temp == NULL) {
        return EXIT_FAILURE;
    }

    temp->data = data;
    temp->priority = priority;
    temp->next = NULL;

    // If new node priority is less than head, insert it first
    // if (priority < (*head)->priority) {
    //     temp->next = *head;
    //     *head = temp;
    //     return EXIT_SUCCESS;
    // }

    while (curr->next != NULL) {
        if (curr->next->priority == priority) {
            if (curr->next->data->data > data->data) {
                break;
            }
        } else if (curr->next->priority > priority) {
            break;
        }
        curr = curr->next;
    }
    temp->next = curr->next;
    curr->next = temp;

    return EXIT_SUCCESS;
}

void
destroy_pq(pqnode* head)
{
    pqnode* curr;

    while (head != NULL) {
        curr = head;
        head = head->next;
        free(curr);
    }
}

void
count_characters(FILE* fp, unsigned char* ascii, unsigned long* count)
{
    int c;

    while ((c = fgetc(fp)) != EOF) {
        if (c < 0) {
            break;
        }

        if (c == ascii[c]) {
            count[c]++;
        } else {
            ascii[c] = c;
            count[c] = 1;
        }
    }
}

int
pq_len(pqnode* head)
{
    int ret = 0;

    while (head != NULL) {
        head = head->next;
        ret++;
    }

    return ret;
}

void
print_pq(pqnode* pq)
{
    while (pq != NULL) {
        printf("%u:%c->", pq->data->count, pq->data->data);
        pq = pq->next;
    }
    printf("NULL\n");
    printf("\n");
}

pqnode*
build_forest(unsigned char* ascii, unsigned long* count)
{
    pqnode* forest_head = calloc(1, sizeof(pqnode));
    if (forest_head == NULL) {
        return NULL;
    }

    int i = 0;

    for (i = 0; i <= 255; i++) {
        if (count[i] > 0) {
            btree* into_forest = calloc(1, sizeof(btree));
            if (into_forest == NULL) {
                return NULL;
            }
            into_forest->data  = ascii[i];
            into_forest->count = count[i];
            into_forest->right = NULL;
            into_forest->left  = NULL;
            if (enqueue(&forest_head, into_forest, count[i]) == EXIT_FAILURE) {
                return NULL;
            }
        }
    }
    dequeue(&forest_head);

    return forest_head;
}

btree*
// build_huffman_tree(char* filename, unsigned char* ascii, unsigned long* count)
build_huffman_tree(pqnode* forest_head)
{
    btree* ret_tree = calloc(1, sizeof(btree));
    if (ret_tree == NULL) {
        return NULL;
    }
    // FIX: Head currently has priority 0;
    // pqnode* forest_head = calloc(1, sizeof(pqnode));
    //
    // int i = 0;
    //
    // for (i = 0; i <= 255; i++) {
    //     if (count[i] > 0) {
    //         btree* into_forest = calloc(1, sizeof(btree));
    //         into_forest->data  = ascii[i];
    //         into_forest->count = count[i];
    //         into_forest->right = NULL;
    //         into_forest->left  = NULL;
    //         enqueue(&forest_head, into_forest, count[i]);
    //     }
    // }
    // dequeue(&forest_head);

    while (pq_len(forest_head) > 2) {
        // print_pq(forest_head);
        btree* t_one = dequeue(&forest_head);
        btree* t_two = dequeue(&forest_head);
        btree* new = calloc(1, sizeof(btree));
        if (new == NULL) {
            return NULL;
        }
        new->count = t_one->count + t_two->count;
        new->left  = t_one;
        new->right = t_two;
        new->data = 255;
        if (enqueue(&forest_head, new, new->count) == EXIT_FAILURE) {
            return NULL;
        }
        // treeprint(new, 0);
    }
    btree* t_one = dequeue(&forest_head);
    btree* t_two = dequeue(&forest_head);
    ret_tree->count = t_one->count + t_two->count;
    ret_tree->left  = t_one;
    ret_tree->right = t_two;

    // treeprint(ret_tree, 0);

    // destroy_pq(forest_head);

    return ret_tree;
}

void
free_tree(btree* root)
{
    if (root == NULL) {
        return;
    }

    free_tree(root->left);
    free_tree(root->right);
    free(root);
}

void
build_file_one(char* filename, unsigned char* ascii, unsigned long* count)
{
    FILE* fp = fopen(filename, "wb");
    int i;
    for (i = 0; i <= 255; i++) {
        fwrite(&count[i], sizeof(long), 1, fp);
    }
    fclose(fp);
}

void
build_file_two(char* filename, pqnode* forest_head)
{
    pqnode* curr;
    curr = forest_head;
    FILE* fp = fopen(filename, "w");
    while (curr != NULL) {
        fprintf(fp, "%c:%ld->", curr->data->data, curr->priority);
        curr = curr->next;
    }
    fprintf(fp, "NULL\n");
    fclose(fp);
}

// https://stackoverflow.com/questions/19284579/accessing-the-bits-in-a-char
unsigned char 
get_bit(unsigned char c, unsigned int pos)
{
    // unsigned char tmp = 1 << pos;
    // return (c & tmp) >> pos;
    return (c >> pos) & 1;
}

int
put_bit(Byte* byte, unsigned char bit)
{
    if (byte->index > 7) {
        fwrite(&(byte->byte), 1, sizeof(unsigned char), byte->fp);
        byte->index = 0;
        byte->byte = 0x0;
    }

    if (bit == 0) {
        byte->index++;
        return EXIT_FAILURE;
    }

    byte->byte |= (1 << byte->index);
    byte->index++;
    return EXIT_SUCCESS;
}

unsigned char
fgetbit(Byte* byte)
{
    if (byte->index > 7) {
        byte->byte = fgetc(byte->fp);
        byte->index = 0;
    }
    unsigned char c = get_bit(byte->byte, byte->index);
    byte->index++;

    return c;
}

unsigned char
fgetbyte(Byte* byte)
{
    unsigned char c = 0x0;
    unsigned char bit;
    for (int i = 0; i <= 7; i++) {
        bit = fgetbit(byte);
        if (bit == 1)
            c |= (1 << (byte->index - 1));
    }

    return c;
}

btree*
preorder_rebuild(Byte* byte)
{
    btree* new = malloc(sizeof(btree));

    if (fgetbit(byte) == 1) {
        unsigned char bytenew = fgetbyte(byte);
        new->data = bytenew;
        new->left = NULL;
        new->right = NULL;
        return new;
    } else {
        new->data = 255;
    }

    new->left = preorder_rebuild(byte);
    new->right = preorder_rebuild(byte);

    return new;
}

void
encode_tree(btree* root, Byte* byte)
{
    if (root->left != NULL && root->right != NULL) {
        put_bit(byte, 0);
        encode_tree(root->left, byte);
        encode_tree(root->right, byte);
    } else {
        put_bit(byte, 1);
        for (int i = 0; i <= 7; i++) {
            put_bit(byte, get_bit(root->data, i));
        }
    }
}

void print_array(FILE* fp, int arr[], int n)
{
    int i;
    for (i = 0; i < n; i++) {
        fprintf(fp, "%d", arr[i]);
    }

    fprintf(fp, "\n");
}

void
codes(FILE* fp, btree* root, int* arr, int depth)
{

    if (root->left) {
        arr[depth] = 0;
        codes(fp, root->left, arr, depth + 1);
    }

    if (root->right) {
        arr[depth] = 1;
        codes(fp, root->right, arr, depth + 1);
    }

    if (root->left == NULL && root->right == NULL) {
        fprintf(fp, "%c:", root->data);
        print_array(fp, arr, depth);

        // int i;
        // for (i = 0; i < depth; i++) {
        //     fprintf(fp, "%d", arr[depth]);
        // }
        // fprintf(fp, "\n");
    }
}
