#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "answer05.h"

void postorder_print(btree* tree, Byte* byte)
{
    if (tree == NULL) {
        return;
    }
    postorder_print(tree->left, byte);
    postorder_print(tree->right, byte);

    if (tree->left == NULL && tree->right == NULL) {
        put_bit(byte, 1);
        for (int i = 0; i <= 7; i++) {
            put_bit(byte, get_bit(tree->data, i));
        }
    } else {
        put_bit(byte, 0);
    }
    // fprintf(stdout, "%c ", tree->data);
    // fwrite(&(tree->data), 1, sizeof(unsigned char), fp);
}

void treeprint(btree* root, int level)
{
    if (root == NULL)
        return;
    for (int i = 0; i < level; i++)
        printf(i == level - 1 ? "|-" : "  ");
    printf("%c\n", root->data);
    treeprint(root->left, level + 1);
    treeprint(root->right, level + 1);
}

int
main(int argc, char** argv)
{
    unsigned char* ascii = calloc(256, sizeof(char));
    unsigned long* ascii_count = calloc(256, sizeof(long));

    // fseek(input_file, 0, SEEK_END);
    // size_t size = ftell(input_file);
    // fseek(input_file, 0, SEEK_SET);


    // if (size == 0) {
    //     count_characters(fpcc, ascii, ascii_count);
    //     fclose(fpcc);
    //     build_file_one(argv[2], ascii, ascii_count);
    //     build_file_two(argv[3], NULL);
    //     free(ascii);
    //     free(ascii_count);
    //     return EXIT_SUCCESS;
    // }

    if (argv != 3) {
        return EXIT_FAILURE;
    }

    FILE* fp_input = fopen(argv[2], "r");
    if (fp_input == NULL) {
        free(ascii);
        free(ascii_count);
        return EXIT_FAILURE;
    }

    count_characters(fp_input, ascii, ascii_count);
    fclose(fp_input);

    // build_file_one(argv[2], ascii, ascii_count);

    pqnode* forest_head = build_forest(ascii, ascii_count);
    if (forest_head == NULL) {
        free(ascii);
        free(ascii_count);
        return EXIT_FAILURE;
    }

    // build_file_two(argv[3], forest_head);

    btree* final = build_huffman_tree(forest_head);
    if (final == NULL) {
        free(ascii);
        free(ascii_count);
        return EXIT_FAILURE;
    }

    Byte* input_file_byte = malloc(sizeof(Byte));
    if (input_file_byte == NULL) {
        return EXIT_FAILURE;
    }
    input_file_byte->fp = fopen(argv[2], "r");
    if (input_file_byte->fp == NULL) {
        return EXIT_FAILURE;
    }
    input_file_byte->byte = 0x0;
    input_file_byte->index = 0;

    Byte* output_file_byte = malloc(sizeof(Byte));
    if (output_file_byte == NULL) {
        return EXIT_FAILURE;
    }
    output_file_byte->fp = fopen(argv[3], "w");
    if (output_file_byte->fp == NULL) {
        return EXIT_FAILURE;
    }
    output_file_byte->byte = 0x0;
    output_file_byte->index = 0;

    if (strcmp(argv[1], "-e") == 0) {
        encode_tree(final, output_file_byte);
        if (output_file_byte->index > 0) {
            fwrite(&(output_file_byte->byte), 1, sizeof(unsigned char), output_file_byte->fp);
        }
    } else if (strcmp(argv[1], "-d") == 0) {
        input_file_byte->byte = fgetc(input_file_byte->fp);
        btree* test = preorder_rebuild(input_file_byte);
        postorder_print(test, output_file_byte);
        if (output_file_byte->index > 0) {
            fwrite(&(output_file_byte->byte), 1, sizeof(unsigned char), output_file_byte->fp);
        }
        free_tree(test);
    }

    
    fclose(input_file_byte->fp);
    fclose(output_file_byte->fp);
    free(input_file_byte);
    free(output_file_byte);


    free_tree(final);
    free(ascii);
    free(ascii_count);

    return EXIT_SUCCESS;
}
