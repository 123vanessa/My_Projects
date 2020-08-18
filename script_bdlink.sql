DO $$DECLARE
 vId_Cliente     integer;
 vInserirCliente Integer;
 vRetorno varchar;
 vRegistro Varchar;
 rc record;
 vRec record;
 vcodCliente Integer;
 vSeqPedido Integer;
 vIdPedido Integer;
 vRegistroErro Integer;
 vCep          Varchar;
 vAux          varchar;

BEGIN

 --insert into xxx values ( '1');
   Select 0 into vRegistroErro ;
   Select 0 into vInserirCliente;

   SELECT DBLINK_CONNECT('conn', 'dbname=caseweb host=201.39.69.75 user=postgres password=postgres port=5432') into vRetorno ;


   -- integrando cidade
   FOR RC IN ( SELECT 555 nroempresa ,c.cep, c.cidade, c.uf FROM cidades C )
   LOOP
 -- insert into xxx values ( '1'); 
   
      vRegistro := 'INSERT INTO ic_cidade( nroempresa,  cep,  cidade,  uf )  values ( ';
      vRegistro := Concat( vRegistro,
                         rc.nroempresa,',',
                         chr(39),vCep,chr(39) ,',',
                         chr(39),rc.cidade,chr(39) ,',',
                         chr(39),rc.uf,chr(39)  ,')' ) into vRegistro;

--insert into xxx values ( vRegistro );
      SELECT DBLINK_EXEC('conn', vRegistro) into vRetorno;
   END LOOP;
   
   -- outra tabela
   
  SELECT DBLINK_DISCONNECT('conn') INTO vRetorno ;
Exception
  when others THEN
      If vRegistroErro = 0 then
       SELECT DBLINK_DISCONNECT('conn') INTO vRetorno ;
      else
       raise exception 'Erro é  %', sqlerrm ;
      end if;

END$$;