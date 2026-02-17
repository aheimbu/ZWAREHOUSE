"=============================================================
" Class ZCL_WAREHOUSE_TEST
" Implements IF_OO_ADT_CLASSRUN to test ZCL_PRODUCT
" Demonstrates creating a product, adding/removing stock,
" and printing results to the console
"=============================================================

CLASS zcl_warehouse_test DEFINITION FOR TESTING
 PUBLIC
  FINAL
  CREATE PUBLIC
  DURATION SHORT.

  PRIVATE SECTION.
    METHODS test_all_methods.
ENDCLASS.


CLASS zcl_warehouse_test IMPLEMENTATION.

  METHOD test_all_methods.
    DATA(lo_product) = NEW zcl_product( iv_product_id = 'P001' iv_name = 'TestName' ).
    lo_product->add_stock( 10 ).
    ASSERT lo_product->get_quantity( ) = 10.
    lo_product->remove_stock( 4 ).
    ASSERT lo_product->get_quantity( ) = 6.
  ENDMETHOD.

ENDCLASS.
