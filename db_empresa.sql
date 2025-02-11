PGDMP     !    ,                 {         
   db_empresa    12.16    12.16 3    A           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            B           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            C           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            D           1262    57513 
   db_empresa    DATABASE     �   CREATE DATABASE db_empresa WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Peru.1252' LC_CTYPE = 'Spanish_Peru.1252';
    DROP DATABASE db_empresa;
                postgres    false            �            1255    65710    fn_paisfindbyid(integer)    FUNCTION     G  CREATE FUNCTION public.fn_paisfindbyid(p_idpais integer) RETURNS TABLE(id_pais integer, nombre character varying, estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN

RETURN QUERY
select 
pa.id_pais as id_pais, 
pa.nombre as nombre, 
pa.estado as estado  
from pais pa 
where pa.estado = 1 and
pa.id_pais = p_idPais;

END
$$;
 8   DROP FUNCTION public.fn_paisfindbyid(p_idpais integer);
       public          postgres    false            �            1259    57603    pais    TABLE     r   CREATE TABLE public.pais (
    id_pais integer NOT NULL,
    estado integer,
    nombre character varying(255)
);
    DROP TABLE public.pais;
       public         heap    postgres    false            �            1255    65717 )   fn_paisinsert(character varying, integer)    FUNCTION     �  CREATE FUNCTION public.fn_paisinsert(p_nombre character varying, p_estado integer) RETURNS SETOF public.pais
    LANGUAGE plpgsql
    AS $$
  DECLARE
    new_id int;
    returnrec pais;
  BEGIN
  	
		insert into  pais( nombre, estado)
		values(p_nombre,p_estado) RETURNING id_pais INTO new_id;
        FOR returnrec IN SELECT * FROM pais where id_pais=new_id LOOP
            RETURN NEXT returnrec;
        END LOOP;
  END;
  $$;
 R   DROP FUNCTION public.fn_paisinsert(p_nombre character varying, p_estado integer);
       public          postgres    false    208            �            1255    65709    fn_paislistall()    FUNCTION       CREATE FUNCTION public.fn_paislistall() RETURNS TABLE(id_pais integer, nombre character varying, estado integer)
    LANGUAGE plpgsql
    AS $$
BEGIN

RETURN QUERY
select pa.id_pais as id_pais, pa.nombre as nombre, pa.estado as estado  from pais pa where pa.estado = 1;

END
$$;
 '   DROP FUNCTION public.fn_paislistall();
       public          postgres    false            �            1255    65719 2   fn_paisupdate(integer, character varying, integer)    FUNCTION     �  CREATE FUNCTION public.fn_paisupdate(p_idpais integer, p_nombre character varying, p_estado integer) RETURNS SETOF public.pais
    LANGUAGE plpgsql
    AS $$
  DECLARE
    new_id int;
    returnrec pais;
  BEGIN
  		
		update pais 
		set 
		nombre = p_nombre,
		estado = p_estado
		where id_pais = p_idpais
		RETURNING id_pais INTO new_id;
		
        FOR returnrec IN SELECT * FROM pais where id_pais=new_id LOOP
            RETURN NEXT returnrec;
        END LOOP;
  END;
  $$;
 d   DROP FUNCTION public.fn_paisupdate(p_idpais integer, p_nombre character varying, p_estado integer);
       public          postgres    false    208            �            1259    57580    cliente_venta    TABLE     f   CREATE TABLE public.cliente_venta (
    id_cliente integer NOT NULL,
    id_venta integer NOT NULL
);
 !   DROP TABLE public.cliente_venta;
       public         heap    postgres    false            �            1259    57587    clientes    TABLE     P  CREATE TABLE public.clientes (
    id bigint NOT NULL,
    apellidos character varying(200) NOT NULL,
    create_at timestamp(6) without time zone,
    email character varying(40) NOT NULL,
    estado integer,
    nombres character varying(200) NOT NULL,
    nro_documento character varying(9) NOT NULL,
    id_pais integer NOT NULL
);
    DROP TABLE public.clientes;
       public         heap    postgres    false            �            1259    57585    clientes_id_seq    SEQUENCE     x   CREATE SEQUENCE public.clientes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.clientes_id_seq;
       public          postgres    false    204            E           0    0    clientes_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;
          public          postgres    false    203            �            1259    57595    detalle_ventas    TABLE     �   CREATE TABLE public.detalle_ventas (
    id bigint NOT NULL,
    cantidad integer,
    precio double precision,
    sub_total double precision,
    id_producto integer NOT NULL,
    id_venta bigint NOT NULL
);
 "   DROP TABLE public.detalle_ventas;
       public         heap    postgres    false            �            1259    57593    detalle_ventas_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.detalle_ventas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.detalle_ventas_id_seq;
       public          postgres    false    206            F           0    0    detalle_ventas_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.detalle_ventas_id_seq OWNED BY public.detalle_ventas.id;
          public          postgres    false    205            �            1259    57601    pais_id_pais_seq    SEQUENCE     �   CREATE SEQUENCE public.pais_id_pais_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.pais_id_pais_seq;
       public          postgres    false    208            G           0    0    pais_id_pais_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.pais_id_pais_seq OWNED BY public.pais.id_pais;
          public          postgres    false    207            �            1259    57611 	   productos    TABLE     �   CREATE TABLE public.productos (
    id integer NOT NULL,
    cantidad integer,
    descripcion character varying(255),
    estado integer
);
    DROP TABLE public.productos;
       public         heap    postgres    false            �            1259    57609    productos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.productos_id_seq;
       public          postgres    false    210            H           0    0    productos_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;
          public          postgres    false    209            �            1259    57619    ventas    TABLE     �   CREATE TABLE public.ventas (
    id bigint NOT NULL,
    fecha timestamp(6) without time zone,
    numero character varying(255),
    serie character varying(255),
    total double precision
);
    DROP TABLE public.ventas;
       public         heap    postgres    false            �            1259    57617    ventas_id_seq    SEQUENCE     v   CREATE SEQUENCE public.ventas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.ventas_id_seq;
       public          postgres    false    212            I           0    0    ventas_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;
          public          postgres    false    211            �
           2604    57590    clientes id    DEFAULT     j   ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);
 :   ALTER TABLE public.clientes ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    204    203    204            �
           2604    57598    detalle_ventas id    DEFAULT     v   ALTER TABLE ONLY public.detalle_ventas ALTER COLUMN id SET DEFAULT nextval('public.detalle_ventas_id_seq'::regclass);
 @   ALTER TABLE public.detalle_ventas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    206    205    206            �
           2604    57606    pais id_pais    DEFAULT     l   ALTER TABLE ONLY public.pais ALTER COLUMN id_pais SET DEFAULT nextval('public.pais_id_pais_seq'::regclass);
 ;   ALTER TABLE public.pais ALTER COLUMN id_pais DROP DEFAULT;
       public          postgres    false    207    208    208            �
           2604    57614    productos id    DEFAULT     l   ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);
 ;   ALTER TABLE public.productos ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            �
           2604    57622 	   ventas id    DEFAULT     f   ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);
 8   ALTER TABLE public.ventas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212            4          0    57580    cliente_venta 
   TABLE DATA           =   COPY public.cliente_venta (id_cliente, id_venta) FROM stdin;
    public          postgres    false    202   �>       6          0    57587    clientes 
   TABLE DATA           l   COPY public.clientes (id, apellidos, create_at, email, estado, nombres, nro_documento, id_pais) FROM stdin;
    public          postgres    false    204   �>       8          0    57595    detalle_ventas 
   TABLE DATA           `   COPY public.detalle_ventas (id, cantidad, precio, sub_total, id_producto, id_venta) FROM stdin;
    public          postgres    false    206   �?       :          0    57603    pais 
   TABLE DATA           7   COPY public.pais (id_pais, estado, nombre) FROM stdin;
    public          postgres    false    208   �?       <          0    57611 	   productos 
   TABLE DATA           F   COPY public.productos (id, cantidad, descripcion, estado) FROM stdin;
    public          postgres    false    210   P@       >          0    57619    ventas 
   TABLE DATA           A   COPY public.ventas (id, fecha, numero, serie, total) FROM stdin;
    public          postgres    false    212   m@       J           0    0    clientes_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.clientes_id_seq', 9, true);
          public          postgres    false    203            K           0    0    detalle_ventas_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.detalle_ventas_id_seq', 1, false);
          public          postgres    false    205            L           0    0    pais_id_pais_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.pais_id_pais_seq', 24, true);
          public          postgres    false    207            M           0    0    productos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.productos_id_seq', 1, false);
          public          postgres    false    209            N           0    0    ventas_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.ventas_id_seq', 1, false);
          public          postgres    false    211            �
           2606    57584     cliente_venta cliente_venta_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY public.cliente_venta
    ADD CONSTRAINT cliente_venta_pkey PRIMARY KEY (id_cliente, id_venta);
 J   ALTER TABLE ONLY public.cliente_venta DROP CONSTRAINT cliente_venta_pkey;
       public            postgres    false    202    202            �
           2606    57592    clientes clientes_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public            postgres    false    204            �
           2606    57600 "   detalle_ventas detalle_ventas_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.detalle_ventas DROP CONSTRAINT detalle_ventas_pkey;
       public            postgres    false    206            �
           2606    57608    pais pais_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.pais
    ADD CONSTRAINT pais_pkey PRIMARY KEY (id_pais);
 8   ALTER TABLE ONLY public.pais DROP CONSTRAINT pais_pkey;
       public            postgres    false    208            �
           2606    57616    productos productos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public            postgres    false    210            �
           2606    57627    ventas ventas_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.ventas DROP CONSTRAINT ventas_pkey;
       public            postgres    false    212            �
           2606    57628 )   cliente_venta fk4nxrvik49yubf6wutaf5y7avl    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente_venta
    ADD CONSTRAINT fk4nxrvik49yubf6wutaf5y7avl FOREIGN KEY (id_cliente) REFERENCES public.clientes(id);
 S   ALTER TABLE ONLY public.cliente_venta DROP CONSTRAINT fk4nxrvik49yubf6wutaf5y7avl;
       public          postgres    false    202    204    2728            �
           2606    57648 *   detalle_ventas fk6457hpcqok31dpejm2gv2x5uu    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT fk6457hpcqok31dpejm2gv2x5uu FOREIGN KEY (id_venta) REFERENCES public.ventas(id);
 T   ALTER TABLE ONLY public.detalle_ventas DROP CONSTRAINT fk6457hpcqok31dpejm2gv2x5uu;
       public          postgres    false    206    212    2736            �
           2606    57643 *   detalle_ventas fk7n95cag4p1jy8dajap81mg56a    FK CONSTRAINT     �   ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT fk7n95cag4p1jy8dajap81mg56a FOREIGN KEY (id_producto) REFERENCES public.productos(id);
 T   ALTER TABLE ONLY public.detalle_ventas DROP CONSTRAINT fk7n95cag4p1jy8dajap81mg56a;
       public          postgres    false    210    206    2734            �
           2606    57638 $   clientes fkch2pdn03yxvoyq4mmwh81i7rm    FK CONSTRAINT     �   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT fkch2pdn03yxvoyq4mmwh81i7rm FOREIGN KEY (id_pais) REFERENCES public.pais(id_pais);
 N   ALTER TABLE ONLY public.clientes DROP CONSTRAINT fkch2pdn03yxvoyq4mmwh81i7rm;
       public          postgres    false    208    204    2732            �
           2606    57633 )   cliente_venta fkgmpj7425rb4tfoud1tkob78cv    FK CONSTRAINT     �   ALTER TABLE ONLY public.cliente_venta
    ADD CONSTRAINT fkgmpj7425rb4tfoud1tkob78cv FOREIGN KEY (id_venta) REFERENCES public.ventas(id);
 S   ALTER TABLE ONLY public.cliente_venta DROP CONSTRAINT fkgmpj7425rb4tfoud1tkob78cv;
       public          postgres    false    212    2736    202            4      x������ � �      6   �   x�]��� �sy
^@B���ɽ���Ѱ�0g��z�#M/����9!'��f Mf��A+q�	�i��8�?|��@HgYӲ���@����-Ͳ��%�f�'�Hȼ��� kZW4�'n�NA�eMZo�rT�
��<�!�jB�ۂQ�v�u���J2�6˃a�K8���=����A	!���NA      8      x������ � �      :   �   x�M���0D��cP����X�)V��&(���W���1�N����l4'��H]\讖!W84�B���*8���&3eR��U���ӗ�P��h� ).c+�i�^���������
5j%v��@٢�I���	P�w/�A�ڪ"����3�e �P<�      <      x������ � �      >      x������ � �     