CLASS ltcl_storage_bin DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA lo_bin TYPE REF TO zcl_storage_bin.
    DATA lo_prod1 TYPE REF TO zcl_product.
    DATA lo_prod2 TYPE REF TO zcl_product.

    METHODS: setup,
      test_constructor         FOR TESTING,
      test_add_and_get_product FOR TESTING,
      test_remove_product      FOR TESTING,
      test_get_bin_id          FOR TESTING,
      test_print_all_products  FOR TESTING.

ENDCLASS.


CLASS ltcl_storage_bin IMPLEMENTATION.

" setup provides new objects for every method
  METHOD setup.
    lo_bin = NEW zcl_storage_bin( iv_bin_id = 'BIN001' ).
    lo_prod1 = NEW zcl_product( iv_product_id = 'P001' iv_name = 'ProductA' ).
    lo_prod2 = NEW zcl_product( iv_product_id = 'P002' iv_name = 'ProductB' ).
  ENDMETHOD.


  METHOD test_constructor.
    cl_abap_unit_assert=>assert_equals(
      act = lo_bin->get_bin_id( )
      exp = 'BIN001'
      msg = 'Wrong bin_id' ).
  ENDMETHOD.


  METHOD test_add_and_get_product.
    lo_bin->add_product( lo_prod1 ).
    lo_bin->add_product( lo_prod2 ).

    DATA(lo_check1) = lo_bin->get_product_by_id( 'P001' ).
    cl_abap_unit_assert=>assert_equals(
    act = lo_check1->get_name( )
    exp = 'ProductA'
    msg = 'P001 not found' ).

    DATA(lo_check2) = lo_bin->get_product_by_id( 'P002' ).
    cl_abap_unit_assert=>assert_equals(
    act = lo_check2->get_name( )
    exp = 'ProductB'
    msg = 'P002 not found' ).

    DATA(lo_none) = lo_bin->get_product_by_id( 'P999' ).
    cl_abap_unit_assert=>assert_initial( lo_none ).
  ENDMETHOD.


  METHOD test_remove_product.
    lo_bin->add_product( lo_prod1 ).
    lo_bin->add_product( lo_prod2 ).

    lo_bin->remove_product( 'P001' ).
    cl_abap_unit_assert=>assert_initial( lo_bin->get_product_by_id( 'P001' ) ).

    cl_abap_unit_assert=>assert_not_initial( lo_bin->get_product_by_id( 'P002' ) ).

    lo_bin->remove_product( 'P999' ).
    cl_abap_unit_assert=>assert_not_initial( lo_bin->get_product_by_id( 'P002' ) ).
  ENDMETHOD.


  METHOD test_get_bin_id.
    cl_abap_unit_assert=>assert_equals(
    act = lo_bin->get_bin_id( )
    exp = 'BIN001' ).
  ENDMETHOD.


  METHOD test_print_all_products.

    lo_bin   = NEW zcl_storage_bin( iv_bin_id = 'BIN001' ).
    lo_prod1 = NEW zcl_product( iv_product_id = 'P001' iv_name = 'ProductA' ).
    lo_prod2 = NEW zcl_product( iv_product_id = 'P002' iv_name = 'ProductB' ).

    lo_bin->add_product( lo_prod1 ).
    lo_bin->add_product( lo_prod2 ).

    DATA(lv_text_from_method) = lo_bin->print_all_products( ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_text_from_method
      exp = |Product: P001 ProductA, Qty: 0{ cl_abap_char_utilities=>newline }Product: P002 ProductB, Qty: 0{ cl_abap_char_utilities=>newline }|
      msg = 'print_all_products provides not the expected text'
    ).
  ENDMETHOD.



ENDCLASS.
