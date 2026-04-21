import { Controller, Get, Inject } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Controller('users')
export class UsersController {
  constructor(@Inject(PrismaService) private prisma: PrismaService) {}

  @Get()
  findAll() {
    return this.prisma.user.findMany({ orderBy: { name: 'asc' } });
  }
}