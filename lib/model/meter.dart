class Meter{
 final String? meter_id;
 final String? channel_id;
 final String? name;
 final String? pu_type_id;
 final String? tariff_type_id;
 final String point_id;
 final String? pu_number;
 final String? measure_multipler;
 final String? date_revise;
 final String? user_lk_id;
 final String? account_id;
 final String? readings_format;
 final String? status;
 final String? date_added;
 final String? date_install;
 final String? tu_name;
 final String? tu_number;
 final String? address;
 final int? index_count;
 final List<Measure> measure;

 Meter({
  required this.meter_id,
  required this.channel_id,
  required this.name,
  required this.pu_type_id,
  required this.tariff_type_id,
  required this.point_id,
  required this.pu_number,
  required this.measure_multipler,
  required this.date_revise,
  required this.user_lk_id,
  required this.account_id,
  required this.readings_format,
  required this.status,
  required this.date_added,
  required this.date_install,
  required this.tu_name,
  required this.tu_number,
  required this.address,
  required this.index_count,
  required this.measure});
 factory Meter.fromMap(Map<dynamic, dynamic> meter){

  return Meter(
   meter_id: meter['meter_id'],
   channel_id: meter['channel_id'],
   name: meter['name'],
   pu_type_id: meter['pu_type_id'],
   tariff_type_id: meter['tariff_type_id'],
   point_id: meter['point_id'],
   pu_number: meter['pu_number'],
   measure_multipler: meter['measure_multipler'],
   date_revise: meter['date_revise'],
   user_lk_id: meter['user_lk_id'],
   account_id: meter['account_id'],
   readings_format: meter['readings_format'],
   status: meter['status'],
   date_added: meter['date_added'],
   date_install: meter['date_install'],
   tu_name: meter['tu_name'],
   tu_number: meter['tu_number'],
   address: meter['address'],
   index_count: meter['index_count'], measure: [],
  );
 }

}
class Measure{
 final String? readings_quantity_id;
 final String? format;
 final String? name;

 Measure(this.readings_quantity_id, this.format, this.name);
}
class LastReadings{
 final String? readings_id;
 final String? date;
 final String? meter_id;
 final String? indication_index;
 final String? reading;
 final String? readings_source_id;
 final String? readings_analyze_id;
 final String? readings_period_id;
 final String? date_added;
 final String? user_lkrso_id;
 final String? readings_integration_responce_id;
 final String? name;
 final String? priority;
 final String? status;

 LastReadings(
      this.readings_id,
      this.date,
      this.meter_id,
      this.indication_index,
      this.reading,
      this.readings_source_id,
      this.readings_analyze_id,
      this.readings_period_id,
      this.date_added,
      this.user_lkrso_id,
      this.readings_integration_responce_id,
      this.name,
      this.priority,
      this.status);
}