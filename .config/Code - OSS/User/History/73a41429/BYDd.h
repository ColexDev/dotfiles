typedef struct _btree {
    unsigned char data;
    unsigned int count;
    struct _btree* right;
    struct _btree* left;
} btree;

typedef struct _pqnode {
    btree* data;
    unsigned long priority;
    struct _pqnode* next;
} pqnode;

typedef struct _byte {
    FILE* fp;
    unsigned char byte;
    unsigned char index;
} Byte;

void count_characters(FILE* fp, unsigned char* ascii, unsigned long* count);
btree* dequeue(pqnode** head);
int enqueue(pqnode** head, btree* data, unsigned long priority);
void destroy_pq(pqnode* head);

// btree* build_huffman_tree(char* filename, unsigned char* ascii, unsigned long* count);
btree* build_huffman_tree(pqnode* forest_head);
void encode_tree(btree* root, Byte* byte);
btree* postorder_rebuild(Byte* byte);
void free_tree(btree* root);
pqnode* build_forest(unsigned char* ascii, unsigned long* count);

void build_file_one(char* filename, unsigned char* ascii, unsigned long* count);
void build_file_two(char* filename, pqnode* forest_head);


void codes(FILE* fp, btree* root, int* arr, int top);


int put_bit(Byte* byte, unsigned char bit);

unsigned char fgetbit(Byte* byte);