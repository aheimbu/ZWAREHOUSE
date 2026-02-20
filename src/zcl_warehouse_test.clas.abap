"=============================================================
" Class ZCL_WAREHOUSE_TEST
" Implements IF_OO_ADT_CLASSRUN to test ZCL_PRODUCT
" Demonstrates creating a product, adding/removing stock,
" and printing results to the console
"=============================================================

CLASS zcl_warehouse_test DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_warehouse_test IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    " zcl_product methods
    DATA(lo_product) = NEW zcl_product( iv_product_id = 'P001' iv_name = 'Testname' ).
    lo_product->add_stock( 10 ).
    ASSERT lo_product->get_quantity( ) = 10.
    lo_product->remove_stock( 4 ).
    ASSERT lo_product->get_quantity( ) = 6.

    " create products
    DATA(lo_prod1) = NEW zcl_product( iv_product_id = 'P001' iv_name = 'ProductA' ).
    DATA(lo_prod2) = NEW zcl_product( iv_product_id = 'P002' iv_name = 'ProductB' ).

    " add stock
    lo_prod1->add_stock( 10 ).
    lo_prod2->add_stock( 5 ).

    " create storage bin
    DATA(lo_bin) = NEW zcl_storage_bin( iv_bin_id = 'BIN01' ).

    " add products to bin
    lo_bin->add_product( lo_prod1 ).
    out->write( |Added products to bin { lo_bin->get_bin_id( ) }| ).
    lo_bin->add_product( lo_prod2 ).
    out->write( |Added products to bin { lo_bin->get_bin_id( ) }| ).

    " list product in bin by id
    DATA(lo_check1) = lo_bin->get_product_by_id( 'P001' ).
    IF lo_check1 IS NOT INITIAL.
      out->write( |Found product by id: { lo_check1->get_product_id( ) } { lo_check1->get_name( ) } Qty: { lo_check1->get_quantity( ) }| ).
    ELSE.
      out->write( 'Product P001 not found' ).
    ENDIF.

    " list products in bin
    out->write( lo_bin->print_all_products( )  ).

    " remove a product
    lo_bin->remove_product( 'P001' ).
    out->write( 'Removed product P001' ).

    " list products in bin
    out->write( lo_bin->print_all_products( )  ).

  ENDMETHOD.

ENDCLASS.
