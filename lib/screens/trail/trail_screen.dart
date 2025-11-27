import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ====== 모델 클래스들: 반드시 top-level 에 있어야 함 ======
class _TrailPoint {
  final double x; // 0 ~ 100 (percent)
  final double y; // 0 ~ 100 (percent)
  final bool offTrail;

  const _TrailPoint({
    required this.x,
    required this.y,
    required this.offTrail,
  });
}

class _Facility {
  final int id;
  final String name;
  final IconData icon;
  final String type;
  final double top; // percent
  final double left; // percent
  final Color color;
  final Color bg;

  const _Facility({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
    required this.top,
    required this.left,
    required this.color,
    required this.bg,
  });
}

class _CairnMessage {
  final String user;
  final String text;
  final String date;

  const _CairnMessage({
    required this.user,
    required this.text,
    required this.date,
  });
}

class _StoneCairn {
  final int id;
  final double top; // percent
  final double left; // percent
  final int pathIndex;
  final int points;
  final List<_CairnMessage> messages;

  const _StoneCairn({
    required this.id,
    required this.top,
    required this.left,
    required this.pathIndex,
    required this.points,
    required this.messages,
  });
}

/// ====== 화면 위젯 ======

class TrailScreen extends StatefulWidget {
  const TrailScreen({Key? key}) : super(key: key);

  @override
  State<TrailScreen> createState() => _TrailScreenState();
}

class _TrailScreenState extends State<TrailScreen> {
  static const int _stopBeforeEnd = 2;

  final List<_TrailPoint> _trailPath = const [
    _TrailPoint(x: 15, y: 85, offTrail: false),
    _TrailPoint(x: 18, y: 80, offTrail: false),
    _TrailPoint(x: 22, y: 74, offTrail: false),
    _TrailPoint(x: 25, y: 70, offTrail: false),
    _TrailPoint(x: 28, y: 66, offTrail: false),
    _TrailPoint(x: 32, y: 62, offTrail: false),
    _TrailPoint(x: 35, y: 60, offTrail: false),
    _TrailPoint(x: 38, y: 56, offTrail: false),
    _TrailPoint(x: 42, y: 52, offTrail: false),
    _TrailPoint(x: 45, y: 48, offTrail: false),
    _TrailPoint(x: 48, y: 46, offTrail: false),
    _TrailPoint(x: 50, y: 45, offTrail: false),
    // Off trail
    _TrailPoint(x: 52, y: 50, offTrail: true),
    _TrailPoint(x: 54, y: 54, offTrail: true),
    _TrailPoint(x: 56, y: 56, offTrail: true),
    _TrailPoint(x: 58, y: 54, offTrail: true),
    // Back on trail
    _TrailPoint(x: 60, y: 48, offTrail: false),
    _TrailPoint(x: 62, y: 42, offTrail: false),
    _TrailPoint(x: 65, y: 36, offTrail: false),
    _TrailPoint(x: 68, y: 32, offTrail: false),
    _TrailPoint(x: 70, y: 30, offTrail: false),
    _TrailPoint(x: 73, y: 26, offTrail: false),
    _TrailPoint(x: 76, y: 22, offTrail: false),
    _TrailPoint(x: 80, y: 18, offTrail: false),
    _TrailPoint(x: 85, y: 15, offTrail: false),
  ];

  final List<_Facility> _facilities = const [
    _Facility(
      id: 1,
      name: "주차장",
      icon: Icons.location_on,
      type: "parking",
      top: 82,
      left: 18,
      color: Colors.blue,
      bg: Color(0xFFDBEAFE),
    ),
    _Facility(
      id: 2,
      name: "매점",
      icon: Icons.local_cafe,
      type: "store",
      top: 50,
      left: 45,
      color: Colors.orange,
      bg: Color(0xFFFFEDD5),
    ),
    _Facility(
      id: 3,
      name: "대피소",
      icon: Icons.park,
      type: "shelter",
      top: 28,
      left: 70,
      color: Colors.green,
      bg: Color(0xFFD1FAE5),
    ),
    _Facility(
      id: 4,
      name: "전망대",
      icon: Icons.landscape,
      type: "viewpoint",
      top: 20,
      left: 78,
      color: Colors.purple,
      bg: Color(0xFFEDE9FE),
    ),
    _Facility(
      id: 5,
      name: "출입금지",
      icon: Icons.warning_amber_rounded,
      type: "restricted",
      top: 65,
      left: 30,
      color: Colors.red,
      bg: Color(0xFFFEE2E2),
    ),
  ];

  final List<_StoneCairn> _stoneCairns = const [
    _StoneCairn(
      id: 1,
      top: 60,
      left: 35,
      pathIndex: 8,
      points: 10,
      messages: [
        _CairnMessage(user: "이산이", text: "첫 등산인데 너무 좋아요!", date: "2024.11.06"),
        _CairnMessage(user: "박자연", text: "여기서 쉬어가세요~", date: "2024.11.05"),
        _CairnMessage(user: "최하이킹", text: "날씨가 완벽합니다!", date: "2024.11.04"),
      ],
    ),
    _StoneCairn(
      id: 2,
      top: 35,
      left: 60,
      pathIndex: 17,
      points: 20,
      messages: [
        _CairnMessage(user: "정산악", text: "반환점까지 힘내세요!", date: "2024.11.06"),
        _CairnMessage(user: "김등산", text: "경치가 정말 멋져요", date: "2024.11.05"),
        _CairnMessage(user: "윤트레킹", text: "조금만 더 가면 정상!", date: "2024.11.03"),
      ],
    ),
  ];

  // ===== 상태 =====
  int _currentIndex = 0;
  bool _isOffTrail = false;
  bool _isPaused = true; // 🔹 처음엔 항상 "정지" 상태
  int _extraTime = 0;
  bool _showAccident = false;
  int? _selectedCairnId;
  Set<int> _visitedCairns = <int>{};
  int? _pointsJustEarned;
  Timer? _moveTimer;
  Timer? _extraTimeTimer;
  bool _endTriggered = false;

  final FocusNode _keyboardFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // 타이머는 돌리지만 _isPaused == true 라서 실제로는 안 움직임
    _startMovement();

    // 화면이 그려진 뒤 키보드 포커스 → 스페이스바 감지
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _keyboardFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _moveTimer?.cancel();
    _extraTimeTimer?.cancel();
    _keyboardFocusNode.dispose();
    super.dispose();
  }

  void _startMovement() {
    _moveTimer?.cancel();
    _moveTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPaused) return; // 🔹 정지 상태면 그대로 대기

      final int maxIndex = _trailPath.length - _stopBeforeEnd;

      if (_currentIndex >= maxIndex - 1) {
        if (!_endTriggered) {
          _endTriggered = true;
          _startExtraTimeCountdown();
          Future.delayed(const Duration(seconds: 2), _triggerAccident);
        }
        return;
      }

      final int nextIndex = _currentIndex + 1;

      setState(() {
        _currentIndex = nextIndex;
        _isOffTrail = _trailPath[nextIndex].offTrail;
      });

      _checkCairns(nextIndex);
    });
  }

  void _startExtraTimeCountdown() {
    _extraTimeTimer?.cancel();
    int added = 0;
    _extraTimeTimer = Timer.periodic(const Duration(milliseconds: 500), (t) {
      if (added >= 4) {
        t.cancel();
        return;
      }
      setState(() {
        _extraTime += 30;
      });
      added++;
    });
  }

  void _triggerAccident() {
    setState(() {
      _showAccident = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _currentIndex = 0;
        _isOffTrail = false;
        _extraTime = 0;
        _showAccident = false;
        _endTriggered = false;
        _visitedCairns.clear();
        _selectedCairnId = null;
        _pointsJustEarned = null;
      });
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _checkCairns(int index) {
    for (final cairn in _stoneCairns) {
      if (index == cairn.pathIndex && !_visitedCairns.contains(cairn.id)) {
        setState(() {
          _visitedCairns = {..._visitedCairns, cairn.id};
          _pointsJustEarned = cairn.points;
        });
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _pointsJustEarned = null;
            });
          }
        });
      }
    }
  }

  double get _distanceKm => ((_currentIndex / _trailPath.length) * 3.2);

  int get _baseTime => ((_currentIndex / _trailPath.length) * 90).floor();

  int get _totalTime => _baseTime + _extraTime;

  int get _altitudeGain =>
      ((_currentIndex / _trailPath.length) * 350).floor();

  _TrailPoint get _currentPosition => _trailPath[_currentIndex];

  // percent(0~100)을 Alignment(-1~1)로 변환
  Alignment _percentToAlignment(double xPercent, double yPercent) {
    final double x = (xPercent / 50.0) - 1.0;
    final double y = (yPercent / 50.0) - 1.0;
    return Alignment(x, y);
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentPosition;

    return Focus(
      autofocus: true,
      focusNode: _keyboardFocusNode,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.enter) {
          _togglePause();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('등산로 추적'),
          centerTitle: true,
          backgroundColor: Colors.teal.shade600,
          actions: [
            IconButton(
              onPressed: _togglePause,
              icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
            ),
          ],
        ),
        body: Column(
          children: [
            // ===== 지도/등산로 영역 =====
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFD1FAE5),
                      Color(0xFFE0F2FE),
                      Color(0xFFECFCCB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // 산 배경 느낌
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade200.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),

                    // 상단 오버레이 (제목 + 상태 뱃지)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF059669),
                                  Color(0xFF0D9488),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(24),
                              ),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '등산로 추적',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '비룡폭포 코스',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                '● 추적 중',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 경로 이탈 경고
                    if (_isOffTrail)
                      Positioned(
                        left: 16,
                        right: 16,
                        top: 120,
                        child: _buildAlert(
                          color: Colors.red.shade50,
                          borderColor: Colors.red.shade500,
                          iconColor: Colors.red.shade600,
                          textColor: Colors.red.shade800,
                          text: '경로 이탈! 등산로로 돌아가세요.',
                        ),
                      ),

                    // 사고 발생 경고
                    if (_showAccident)
                      Positioned(
                        left: 16,
                        right: 16,
                        top: 120,
                        child: _buildAlert(
                          color: Colors.red.shade600,
                          borderColor: Colors.red.shade700,
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          text: '사고 발생!',
                        ),
                      ),

                    // 돌탑 포인트 획득 알림
                    if (_pointsJustEarned != null)
                      Positioned(
                        left: 16,
                        right: 16,
                        top: 120,
                        child: _buildAlert(
                          color: Colors.yellow.shade400,
                          borderColor: Colors.yellow.shade500,
                          iconColor: Colors.yellow.shade700,
                          textColor: Colors.yellow.shade900,
                          text: '${_pointsJustEarned!}점을 얻었습니다!',
                        ),
                      ),

                    // 등산로 그리기
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _TrailPathPainter(),
                      ),
                    ),

                    // 출발지
                    Align(
                      alignment: _percentToAlignment(15, 85),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.location_on,
                                color: Colors.white, size: 20),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              '출발지',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 목적지
                    Align(
                      alignment: _percentToAlignment(85, 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.navigation,
                                color: Colors.white, size: 20),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: const Text(
                              '목적지',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 편의 시설 아이콘
                    ..._facilities.map((f) {
                      return Align(
                        alignment: _percentToAlignment(f.left, f.top),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: f.bg,
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Colors.white, width: 2),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                              child: Icon(
                                f.icon,
                                size: 16,
                                color: f.color,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: f.bg,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                f.name,
                                style: TextStyle(
                                  color: f.color,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),

                    // 돌탑 + 메시지 팝업
                    ..._stoneCairns.map((cairn) {
                      final isSelected = _selectedCairnId == cairn.id;
                      return Stack(
                        children: [
                          Align(
                            alignment:
                            _percentToAlignment(cairn.left, cairn.top),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCairnId =
                                  isSelected ? null : cairn.id;
                                });
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // 돌탑 모양
                                  Column(
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade500,
                                          borderRadius:
                                          BorderRadius.circular(999),
                                          border: Border.all(
                                              color: Colors.grey.shade600),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                              color: Colors.black26,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 18,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade600,
                                          borderRadius:
                                          BorderRadius.circular(999),
                                          border: Border.all(
                                              color: Colors.grey.shade700),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                              color: Colors.black26,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 20,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade700,
                                          borderRadius:
                                          BorderRadius.circular(999),
                                          border: Border.all(
                                              color: Colors.grey.shade800),
                                          boxShadow: const [
                                            BoxShadow(
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                                color: Colors.black26),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  if (!isSelected)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade700,
                                        borderRadius:
                                        BorderRadius.circular(999),
                                      ),
                                      child: const Text(
                                        '돌탑',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          if (isSelected)
                            Positioned.fill(
                              child: Align(
                                alignment: _percentToAlignment(
                                    cairn.left, cairn.top)
                                    .add(const Alignment(0.7, 0)),
                                child: ConstrainedBox(
                                  constraints:
                                  const BoxConstraints(maxWidth: 260),
                                  child: Material(
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white.withOpacity(0.95),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              const Text(
                                                '방문자 메시지',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedCairnId = null;
                                                  });
                                                },
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    Colors.grey.shade100,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 140,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: cairn.messages
                                                    .map(
                                                      (m) => Container(
                                                    margin:
                                                    const EdgeInsets
                                                        .only(
                                                      bottom: 6,
                                                    ),
                                                    padding:
                                                    const EdgeInsets
                                                        .all(8),
                                                    decoration:
                                                    BoxDecoration(
                                                      color: Colors
                                                          .grey.shade50,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(8),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              m.user,
                                                              style:
                                                              const TextStyle(
                                                                fontSize:
                                                                13,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ),
                                                            ),
                                                            Text(
                                                              m.date,
                                                              style:
                                                              const TextStyle(
                                                                fontSize:
                                                                11,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            m.text,
                                                            style:
                                                            const TextStyle(
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),

                    // 등산객 아이콘
                    Align(
                      alignment: _percentToAlignment(current.x, current.y),
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: _isOffTrail ? Colors.red : Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              offset: Offset(0, 4),
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),

                    // 중간 웨이포인트 (노란 점)
                    Align(
                      alignment: _percentToAlignment(50, 45),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade600,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: _percentToAlignment(65, 30),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade600,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              offset: Offset(0, 2),
                              color: Colors.black26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ===== 하단 통계 패널 =====
            Container(
              color: Colors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      _buildStatItem(
                        icon: Icons.location_on,
                        iconColor: Colors.teal.shade600,
                        label: '거리',
                        value: '${_distanceKm.toStringAsFixed(1)} km',
                      ),
                      _buildStatItem(
                        icon: Icons.access_time,
                        iconColor: Colors.blue.shade600,
                        label: '시간',
                        value: '$_totalTime분',
                      ),
                      _buildStatItem(
                        icon: Icons.navigation,
                        iconColor: Colors.orange.shade600,
                        label: '고도',
                        value: '+${_altitudeGain}m',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlert({
    required Color color,
    required Color borderColor,
    required Color iconColor,
    required Color textColor,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(0, 4),
            color: Colors.black26,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: iconColor, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: iconColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// 등산로 곡선을 그리는 Painter (React SVG path 대체)
class _TrailPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(15 / 100 * size.width, 85 / 100 * size.height)
      ..quadraticBezierTo(
        25 / 100 * size.width,
        70 / 100 * size.height,
        35 / 100 * size.width,
        60 / 100 * size.height,
      )
      ..quadraticBezierTo(
        50 / 100 * size.width,
        45 / 100 * size.height,
        65 / 100 * size.width,
        30 / 100 * size.height,
      )
      ..quadraticBezierTo(
        75 / 100 * size.width,
        20 / 100 * size.height,
        85 / 100 * size.width,
        15 / 100 * size.height,
      );

    final outlinePaint = Paint()
      ..color = const Color(0xFF059669).withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final mainPaint = Paint()
      ..color = const Color(0xFF10B981).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, outlinePaint);
    canvas.drawPath(path, mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
