"=============================================================
" Class ZCL_STORAGE_BIN
" Represents a storage bin in the warehouse.
" Holds multiple product objects.
" Allows adding, retrieving and removing products.
"=============================================================

CLASS zcl_storage_bin DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_bin_id TYPE string.

    METHODS add_product
      IMPORTING
        io_product TYPE REF TO zcl_product.

    METHODS get_product_by_id
      IMPORTING
                iv_product_id     TYPE string
      RETURNING VALUE(ro_product) TYPE REF TO zcl_product.

    METHODS remove_product
      IMPORTING iv_product_id TYPE string.

    METHODS get_bin_id
      RETURNING VALUE(rv_bin_id) TYPE string.

    " list products in console
    METHODS print_all_products
      RETURNING VALUE(rv_text) TYPE string.

  PRIVATE SECTION.

    DATA mv_bin_id   TYPE string.
    DATA mt_products TYPE STANDARD TABLE OF REF TO zcl_product WITH EMPTY KEY.

ENDCLASS.



CLASS zcl_storage_bin IMPLEMENTATION.

  METHOD constructor.
    mv_bin_id = iv_bin_id.
  ENDMETHOD.


  METHOD add_product.
    APPEND io_product TO mt_products.
  ENDMETHOD.


  METHOD get_product_by_id.
    LOOP AT mt_products INTO DATA(lo_product).
      IF lo_product->get_product_id( ) = iv_product_id.
        ro_product = lo_product.
        RETURN.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD remove_product.

    DATA lv_index TYPE sy-tabix.

    LOOP AT mt_products INTO DATA(lo_product).
      IF lo_product->get_product_id( ) = iv_product_id.
        lv_index = sy-tabix.
        EXIT.
      ENDIF.
    ENDLOOP.

    IF lv_index IS NOT INITIAL.
      DELETE mt_products INDEX lv_index.
    ENDIF.

  ENDMETHOD.


  METHOD get_bin_id.
    rv_bin_id = mv_bin_id.
  ENDMETHOD.

METHOD print_all_products.
    rv_text = ''.

    LOOP AT mt_products INTO DATA(lo_prod).
      rv_text = rv_text && |Product: { lo_prod->get_product_id( ) } { lo_prod->get_name( ) }, Qty: { lo_prod->get_quantity( ) }{ cl_abap_char_utilities=>newline }|.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
