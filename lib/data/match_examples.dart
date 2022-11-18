import 'package:splooking3/data/match.dart';

Match match1 = PublicMatch(
  id: 'ghujfghsdfusohfsiouhfsdisdiufasdh', 
  name: '昇格戦まで', 
  hostId: 'guchiwo0608', 
  startTime: DateTime(2022, 12, 25, 18, 0), 
  numberOfPeople: 3, 
  member: [], 
  comment: '昇格戦まで付き合ってくれる人募集です', 
  matchType: 'バンカラマッチ(オープン)', 
  rule: 'ガチヤグラ', 
  stage: ['スメーシーワールド', 'ヤガラ市場'],
  options: ['昇格戦まで', 'エンジョイ'],
);

Match match2 = PublicMatch(
  id: 'fjdiskoajfisdohusdfouashfj', 
  name: '月イチリグマ', 
  hostId: 'guchiwo0622', 
  startTime: DateTime(2022, 12, 25, 18, 0), 
  numberOfPeople: 3, 
  member: [], 
  comment: '月イチリグマガチる', 
  matchType: 'リーグマッチ', 
  rule: 'ガチヤグラ', 
  stage: ['スメーシーワールド', 'ヤガラ市場'],
  options: ['ギア開け', 'エンジョイ'],
);

Match match3 = PublicMatch(
  id: 'gjiajfsdifjisdfojsdaio', 
  name: 'ロング部', 
  hostId: 'guchiwo0129', 
  startTime: DateTime(2022, 12, 25, 18, 0), 
  numberOfPeople: 3, 
  member: [], 
  comment: 'ロング部', 
  matchType: 'レギュラーマッチ', 
  rule: '', 
  stage: ['スメーシーワールド', 'ヤガラ市場'],
  options: ['ロング部', 'エンジョイ'],
);

Match match4 = PrivateMatch(
  id: 'gjiajfsdifjisdfojsdaio', 
  name: 'ロング部', 
  hostId: 'guchiwo0129', 
  startTime: DateTime(2022, 12, 25, 18, 0), 
  numberOfPeople: 3, 
  member: [], 
  comment: 'ロング部', 
  rule: ['ガチホコエリア', 'ガチヤグラ'], 
  stage: ['スメーシーワールド', 'ヤガラ市場'],
  options: ['ロング部', 'エンジョイ'],
);

Match match5 = SalmonrunMatch(
  id: 'gjiajfsdifjisdfojsdaio', 
  name: 'ロング部', 
  hostId: 'guchiwo0129', 
  startTime: DateTime(2022, 12, 25, 18, 0), 
  numberOfPeople: 3, 
  member: [], 
  comment: 'ロング部', 
  stage: 'アラマキ砦',
  weapons: ['リッター4K', 'スプラシューター', 'ラピッドブラスター', 'スプラローラー'],
  options: ['エンジョイ'],
);