CREATE TABLE IF NOT EXISTS default.graphite_data (
  Path String CODEC(ZSTD(3)), -- better compression
  Value Float64 CODEC(Gorilla, LZ4), -- better codec for Floats
  Time UInt32 CODEC(DoubleDelta, LZ4), -- will be almost always 0
  Date Date CODEC(DoubleDelta, LZ4), -- will be almost always 0
  Timestamp UInt32 CODEC(DoubleDelta, LZ4) TTL Date + INTERVAL 1 MONTH -- will be almost always 0, good to go in 1 month
) ENGINE = GraphiteMergeTree('graphite_rollup')
PARTITION BY toYearWeek(Date)
ORDER BY (Path, Time);

CREATE TABLE IF NOT EXISTS default.graphite_reverse (
  Path String CODEC(ZSTD(3)), -- better compression
  Value Float64 CODEC(Gorilla, LZ4), -- better codec for Floats
  Time UInt32 CODEC(DoubleDelta, LZ4), -- will be almost always 0
  Date Date CODEC(DoubleDelta, LZ4), -- will be almost always 0
  Timestamp UInt32 CODEC(DoubleDelta, LZ4) TTL Date + INTERVAL 1 MONTH -- will be almost always 0, good to go in 1 month
) ENGINE = GraphiteMergeTree('graphite_rollup')
PARTITION BY toYearWeek(Date)
ORDER BY (Path, Time);

CREATE TABLE IF NOT EXISTS default.graphite_index (
  Date Date CODEC(DoubleDelta, LZ4), -- will be almost always 0
  Level UInt32 CODEC(DoubleDelta, LZ4), -- will be almost always 0
  Path String CODEC(ZSTD(3)), -- better compression
  Version UInt32 TTL toDateTime(Version) + INTERVAL 2 DAY -- is necessary only for the current day
) ENGINE = ReplacingMergeTree(Version)
PARTITION BY toYYYYMMDD(Date)
ORDER BY (Level, Path, Date);

CREATE TABLE IF NOT EXISTS default.graphite_tagged (
  Date Date CODEC(DoubleDelta, LZ4), -- will be almost always 0
  Tag1 String CODEC(ZSTD(3)), -- better compression
  Path String CODEC(ZSTD(3)), -- better compression
  Tags Array(String) CODEC(ZSTD(3)), -- better compression
  Version UInt32 TTL toDateTime(Version) + INTERVAL 2 DAY -- is necessary only for the current day
) ENGINE = ReplacingMergeTree(Version)
PARTITION BY toYYYYMMDD(Date)
ORDER BY (Tag1, Path, Date);
