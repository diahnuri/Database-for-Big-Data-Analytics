// mongo_commands.js
// Import (from shell):  mongoimport --db mpd --collection cdr_events --file cdr_events.jsonl --jsonArray --type=json --legacy
// If using JSON Lines, use: mongoimport --db mpd --collection cdr_events --file cdr_events.jsonl --type json --jsonArray=false

// Example queries (run in mongosh):
// Count docs
db.cdr_events.countDocuments()

// Aggregation: events by type
db.cdr_events.aggregate([
  {$group: {_id: "$event_type", n: {$sum: 1}}},
  {$sort: {n: -1}}
])

// Active subscribers during Ubud Arts Fair (2025-09-19 to 2025-09-21) in Gianyar
db.cdr_events.aggregate([
  {$match: {regency: "Gianyar", event_ts: {$gte: "2025-09-19", $lte: "2025-09-21"}}},
  {$group: {_id: "$subscriber_id"}},
  {$limit: 20}
])

// Travel detection: events outside a hypothetical home regency would require a lookup; here we only have event regency.
// In practice, enrich documents with home_regency via ETL or $lookup from a subscribers collection.
