CLASS ltcl_product DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      test_constructor_and_getters FOR TESTING,
      test_add_stock               FOR TESTING,
      test_remove_stock            FOR TESTING.
ENDCLASS.


CLASS ltcl_product IMPLEMENTATION.

  METHOD test_constructor_and_getters.

    DATA(lo_product) = NEW zcl_product(
        iv_product_id = 'P001'
        iv_name       = 'Testname' ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_product->get_product_id( )
      exp = 'P001' ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_product->get_name( )
      exp = 'Testname' ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_product->get_quantity( )
      exp = 0 ).

  ENDMETHOD.


  METHOD test_add_stock.

    DATA(lo_product) = NEW zcl_product(
        iv_product_id = 'P001'
        iv_name       = 'Testname' ).

    lo_product->add_stock( 18 ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_product->get_quantity( )
      exp = 18 ).

  ENDMETHOD.


  METHOD test_remove_stock.

    DATA(lo_product) = NEW zcl_product(
        iv_product_id = 'P001'
        iv_name       = 'Testname' ).

    lo_product->add_stock( 18 ).
    lo_product->remove_stock( 4 ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_product->get_quantity( )
      exp = 14 ).

  ENDMETHOD.

ENDCLASS.
