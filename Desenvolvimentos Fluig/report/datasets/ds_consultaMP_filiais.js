function createDataset(fields, constraints, sortFields) {
    var newDataset = DatasetBuilder.newDataset();
    var dataSource = "/jdbc/AppDS";
    var ic = new javax.naming.InitialContext();
    var ds = ic.lookup(dataSource);
    var created = false;
    
    var filialConsultaMP = null;

    for (var i = 0; i < constraints.length; i++) {
        if (constraints[i].fieldName == "FILIAL") {
        	filialConsultaMP = constraints[i].initialValue;
        }
    }  		
    var myQuery = 
    	 "SELECT DISTINCT " +
    	 "WORKFLOW.NUM_PROCES AS SOLICITACAO, " +
    	 "WORKFLOW.NR_DOCUMENTO_CARD AS IDPROCESSO, " +
    	 "WORKFLOW.COD_DEF_PROCES AS PROCESSO, " +
    	 "CASE WHEN WORKFLOW.STATUS = '0' THEN 'ABERTA' " +
    	 "WHEN WORKFLOW.STATUS = '1' THEN 'CANCELADA' " +
    	 "WHEN WORKFLOW.STATUS = '2' THEN 'FINALIZADO' " +
    	 "ELSE '' END AS STATUSPPROCESSO, " +
    	 "WORKFLOW.START_DATE AS STARTDATE, " +
    	 "WORKFLOW.COD_MATR_REQUISIT AS SOLICITANTE, " +
    	 "USERN.FULL_NAME AS NOME, " +
    	 "PROCES.CD_MATRICULA AS RESPONSAVEL, " + 
    	 "FORMMP.CODFILIAL AS FILIAL, " +
    	 "MP.FILIAIS_MP AS FILIAL2 " +
    	 "FROM PROCES_WORKFLOW WORKFLOW " +
    	 "LEFT JOIN TAR_PROCES PROCES ON PROCES.NUM_PROCES = WORKFLOW.NUM_PROCES " +
    	 "LEFT JOIN ML0012375 FORMMP ON FORMMP.DOCUMENTID = WORKFLOW.NR_DOCUMENTO_CARD " +
    	 "LEFT JOIN FDN_USERTENANT USERT ON USERT.LOGIN = WORKFLOW.COD_MATR_REQUISIT " +
    	 "LEFT JOIN FDN_USER USERN ON USERN.USER_ID = USERT.USER_ID " +
    	 "LEFT JOIN MP_SUPERINTENDENCIA MP ON MP.SOLICITACAO_MP = WORKFLOW.NUM_PROCES " +
    	 "WHERE PROCES.LOG_ATIV = '1' AND WORKFLOW.STATUS = '0' AND PROCES.CD_MATRICULA = 'Nacime' AND " +
    	 "(FORMMP.CODFILIAL = '"+ filialConsultaMP +"' OR MP.FILIAIS_MP = '"+ filialConsultaMP +"')";
   
 
//  var myQuery = "CREATE TABLE MP_SUPERINTENDENCIA(SOLICITACAO_MP VARCHAR(50) NOT NULL, FILIAIS_MP VARCHAR(50) NOT NULL)"; 
 
//   var myQuery = "INSERT ALL " +
//   "INTO MP_SUPERINTENDENCIA (SOLICITACAO_MP, FILIAIS_MP) VALUES(36221, 27) " +
//   "INTO MP_SUPERINTENDENCIA (SOLICITACAO_MP, FILIAIS_MP) VALUES(36184, 11) " +
//   "SELECT * FROM DUAL ";
       
//    var myQuery = "SELECT * FROM MP_SUPERINTENDENCIA";

//   var myQuery = "SELECT * FROM ML0012375 WHERE ROWNUM < 10";
//   var myQuery = "SELECT * FROM TAR_PROCES WHERE NUM_PROCES = '36466' AND LOG_ATIV = '1'";

    	
//   	var myQuery = "select owner, table_name, column_name "+
//   		"from all_tab_columns " +
//   		"where column_name in ('simQuestionCIPA" +
//   		"')";
    
    

    
   try {
        log.info("TRYCATTT" +myQuery)
        var conn = ds.getConnection();
        var stmt = conn.createStatement();
        var rs = stmt.executeQuery(myQuery);
        var columnCount = rs.getMetaData().getColumnCount();
        log.info("##MPJAF_ columnCount " +rs.getMetaData().getColumnCount());
        var aux = 0;
        while (rs.next()) {
        	 log.info("##MPJAF_WHILE "+created);
            if (!created) {
                for (var i = 1; i <= columnCount; i++) {
                    newDataset.addColumn(rs.getMetaData().getColumnName(i));
                }
                created = true;
            }
            var Arr = new Array();
            for (var i = 1; i <= columnCount; i++) {
                var obj = rs.getObject(rs.getMetaData().getColumnName(i));
                log.info("##MPJAF_ OBJ " +obj);
                if (null != obj) {
                    Arr[i - 1] = rs.getObject(rs.getMetaData().getColumnName(i)).toString();
                    log.info("##MPJAF_ "+rs.getObject(rs.getMetaData().getColumnName(i)).toString())
                } else {
                    Arr[i - 1] = "null";
                }
            }
            newDataset.addRow(Arr);
            aux ++;
        }
        log.info("NEWDATASET - "+newDataset)    
        return newDataset;
    } catch (e) {
        log.info("DEVDEBUG => #11 ERROR DATA SET ReembolsoFiliaisViaBDFluig: " + e.message);
    } finally {
        if (rs != null) {
            rs.close();
        }
        if (stmt != null) {
            stmt.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
    return newDataset;
}