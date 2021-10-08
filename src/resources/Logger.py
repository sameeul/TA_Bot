from datetime import datetime
import json

class Logger(object):
  _instance = None

  def __new__(self):
    if self._instance is None:
      self._instance = super(Logger, self).__new__(self)
      self._event_dict = {}

    return self._instance

  def post_event_telemetry(self, event_data_dict):
    now = datetime.now()
    current_time = now.strftime("%Y-%m-%d %H:%M:%S.%f")
    self._event_dict[current_time] = event_data_dict
    self.update_json_file()   
   
  def update_json_file(self):
    with open("output/work-log.json", "w") as fp:
      json.dump(self._event_dict, fp, indent = 4)

  def post_task_start_info(self, task_name, task_description):
    event_data_dict = {}
    event_data_dict['EventType'] = "Task Start"
    event_data_dict['Name'] = task_name    
    event_data_dict['Description'] = task_description
    self.post_event_telemetry(event_data_dict)
    
  def post_task_end_info(self, task_name, task_description):
    event_data_dict = {}
    event_data_dict['EventType'] = "Task End"
    event_data_dict['Name'] = task_name    
    event_data_dict['Description'] = task_description
    self.post_event_telemetry(event_data_dict)
    
  def post_sub_task_start_info(self, sub_task_name, meta_data_dict):
    event_data_dict = {}
    event_data_dict['EventType'] = "Sub Task Start"
    event_data_dict['Name'] = sub_task_name    
    event_data_dict['MetaData'] = meta_data_dict
    self.post_event_telemetry(event_data_dict)
 
  def post_sub_task_end_info(self, sub_task_name, meta_data_dict):
    event_data_dict = {}
    event_data_dict['EventType'] = "Sub Task End"
    event_data_dict['Name'] = sub_task_name    
    event_data_dict['MetaData'] = meta_data_dict
    self.post_event_telemetry(event_data_dict)
 