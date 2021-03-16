# Entry file
PROD_ENTRY := main

# Directory definitions
INC_DIR := include
SRC_DIR := src
OBJ_DIR := build
BIN_DIR := bin

# Compilation related flags and parameters
CC := gcc
CFLAGS := -Wall -I$(INC_DIR)

INCS_FILES = $(wildcard $(INC_DIR)/*.h)
SRCS_FILES = $(wildcard $(SRC_DIR)/*.c)
OBJS_FILES = $(SRCS_FILES:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)
TARGET_FILES := $(SRCS_FILES:$(SRC_DIR)/%.c=$(BIN_DIR)/%)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

all: list power_of_two bitcpy cstr_bin

list:	$(OBJS_FILES)
	@mkdir -p $(BIN_DIR)
	gcc -o $(BIN_DIR)/list $(OBJ_DIR)/list.o

power_of_two: $(OBJS_FILES)
	@mkdir -p $(BIN_DIR)
	gcc -o $(BIN_DIR)/power_of_two $(OBJ_DIR)/power_of_two.o

bitcpy: $(OBJS_FILES)
	@mkdir -p $(BIN_DIR)
	gcc -o $(BIN_DIR)/bitcpy $(OBJ_DIR)/bitcpy.o

cstr_bin: $(OBJS_FILES)
	@mkdir -p $(BIN_DIR)
	gcc -o $(BIN_DIR)/cstr_bin $(OBJ_DIR)/cstr.o $(OBJ_DIR)/cstr_bin.o

clean:
	-rm $(OBJ_DIR)/*.o $(BIN_DIR)/*

valgrind: all
	@valgrind --leak-check=full $(TARGET_FILES)

cppcheck:
	cppcheck -i $(INCS_FILES) $(SRCS_FILES)
