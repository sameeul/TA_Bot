*** Settings ***
Resource          common.resource

*** Keywords ***	
Log Sub Task Start
	[Arguments]	${sub_task_name}	${sub_task_meta_data_dict}=Default value		
	Post Sub Task Start Info	${sub_task_name}	Optional argument: ${sub_task_meta_data_dict}		

*** Keywords ***	
Log Sub Task End
	[Arguments]	${sub_task_name}	${sub_task_meta_data_dict}=Default value		
	Post Sub Task End Info	${sub_task_name}	Optional argument: ${sub_task_meta_data_dict}		


*** Keywords ***	
Log Task Start
	[Arguments]
	Post Task Start Info	${TEST_NAME}	${TEST_DOCUMENTATION}		

*** Keywords ***	
Log Task End
	[Arguments]
	Post Task End Info	${TEST_NAME}	${TEST_DOCUMENTATION}		