### **프로젝트 기획 배경**

- **실무 환경과 유사한 아키텍처**(React + Spring Boot + MySQL + AWS)를 직접 구축하여 풀스택 역량 강화
- 간편식, 식단, 음료, 의료기기와 같은 **생활 밀접형 상품군**을 바탕으로 검색, 카테고리화, 주문 프로세스를 설계
- 단순 CRUD 구현을 넘어 **보안, 성능, 인프라 운영까지 고려한 학습형 프로젝트**로 진행

### **프로젝트 개발 환경**

- **프론트엔드** : React, TypeScript
- **백엔드** : Java Spring Boot
- **DB** : MySQL
- **인프라** : AWS S3 (이미지 저장소)

### **프로젝트 제작 기간**

- 2025.01 ~ 현재 작업중

### **기능 명세**

- **유저 관련**
    - 회원가입 / 로그인 / 로그아웃 /  비밀번호 찾기 기능
    - 마이페이지 → 주문 내역 및 회원 정보 수정 API 구현
- **상품 관련**
    - 상품 검색 및 카테고리별 조회 기능 (간편식, 식단, 음료, 의료기기)
    - 장바구니 담기 / 삭제 기능
    - 바로구매 기능
    - 주문하기 기능 (상품 선택 → 결제 프로세스 시뮬레이션)

---

### **프로젝트 주안점**

### 1. **사용자 편의성을 고려한 검색 및 카테고리화**

- 상품 카테고리(간편식/식단/음료/의료기기) 별로 상품을 빠르게 조회할 수 있도록 카테고리화 기능 구현

### 2. **보안 및 데이터 무결성 확보**

- 회원가입 시 비밀번호를 해싱하여 DB 저장, 사용자 정보 보안 강화
- 로그인 세션 및 인증 로직을 구현하여 사용자별 장바구니 및 주문 데이터의 무결성 보장

### 3. **실제 서비스 운영에 준하는 인프라 구축**

- **AWS S3를 통한 상품 이미지 저장 및 관리**로 클라우드 환경 활용 능력 확보
- 추후 결제 모듈 연동 및 배포 자동화를 고려한 확장성 높은 아키텍처 설계
  
---
## 커밋 이모티콘 정리

- 수정 및 추가 가능

| 이모티콘                                | 설명                     |
| --------------------------------------- | ------------------------ |
| :tada: `:tada:`                         | new screen               |
| :zap: `:zap:`                           | general fix              |
| :sparkles: `:sparkles:`                 | new feature              |
| :hammer: `:hammer:`                     | refactoring              |
| :bookmark: `:bookmark:`                 | release tag              |
| :bug: `:bug:`                           | bug fix                  |
| :construction: `:construction:`         | work in progress         |
| :ambulance: `:ambulance:`               | critical hot fix         |
| :arrow_up: `:arrow_up:`                 | Upgrading dependencies   |
| :arrow_down: `:arrow_down:`             | Downgrading dependencies |
| :heavy_plus_sign: `:heavy_plus_sign:`   | Adding a dependency      |
| :heavy_minus_sign: `:heavy_minus_sign:` | Removing a dependency    |
| :eyes: `:eyes:`                         | Code Review              |
| :hand: `:hand:`                         | Code Review Request      |
