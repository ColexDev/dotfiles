#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "answer05.h"

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
        postorder_rebuild(input_file_byte);
    }

    
    fclose(input_file_byte->fp);
    fclose(output_file_byte->fp);
    free(input_file_byte);
    free(output_file_byte);

    // int* arr = calloc(100, sizeof(int));
    // FILE* fpc = fopen(argv[5], "w");
    // codes(fpc, final, arr, 0);
    // free(arr);
    // fclose(fpc);

    // FIX: this makes gophers work, but not stone or binary1
    // fprintf(fp3, "\n");

    free_tree(final);
    free(ascii);
    free(ascii_count);

    return EXIT_SUCCESS;
}
