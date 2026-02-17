"=============================================================
" Class ZCL_PRODUCT
" Represents a product in the warehouse.
" Stores product ID, name, and stock quantity.
" Provides methods to add/remove stock and read details.
"=============================================================

CLASS zcl_product DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_product_id TYPE string
        iv_name       TYPE string.

    METHODS get_product_id
      RETURNING VALUE(rv_id) TYPE string.

    METHODS get_name
      RETURNING VALUE(rv_name) TYPE string.

    METHODS get_quantity
      RETURNING VALUE(rv_qty) TYPE i.

    METHODS add_stock
      IMPORTING
        iv_qty TYPE i.

    METHODS remove_stock
      IMPORTING
        iv_qty TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA mv_product_id TYPE string.
    DATA mv_name       TYPE string.
    DATA mv_quantity   TYPE i.

ENDCLASS.


CLASS zcl_product IMPLEMENTATION.

  METHOD constructor.
    mv_product_id = iv_product_id.
    mv_name       = iv_name.
    mv_quantity   = 0.
  ENDMETHOD.

  METHOD get_product_id.
    rv_id = mv_product_id.
  ENDMETHOD.

  METHOD get_name.
    rv_name = mv_name.
  ENDMETHOD.

  METHOD get_quantity.
    rv_qty = mv_quantity.
  ENDMETHOD.

  METHOD add_stock.
    mv_quantity = mv_quantity + iv_qty.
  ENDMETHOD.

  METHOD remove_stock.
    mv_quantity = mv_quantity - iv_qty.
  ENDMETHOD.

ENDCLASS.
