

class Helper {
  static String formatSalaryValue(int value) {
    double num = value.toDouble() / 1000;
    String rs = num.toString();
    String dd = rs.substring(0, rs.indexOf('.') + 2);
    return dd.replaceAll('.0', '');
  }

  static String formatSalary(int from, int to, {bool transform = true}) {

    if (from == null){
      from = 0;
    }

    if (to == null){
      to = 0;
    }

    if (from == 0 && to == 0) {
      return '工资面议';
    }

    if (!transform) {
      return from.toString() + 'K - ' + to.toString() + 'K';
    }

    return formatSalaryValue(from) + 'K - ' + formatSalaryValue(to) + 'K';
  }
}
